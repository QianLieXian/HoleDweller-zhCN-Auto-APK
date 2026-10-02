using System;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using UndertaleModLib.Compiler;
// Android 的 mediump 浮点 UV 累加可能停止前进，改为有上限的整数行号。
// 保留原有调色板采样与颜色插值，不关闭角色换色。
var paletteShader = Data.Shaders.Single(s => s.Name.Content == "shd_pal_swapper");
var paletteFragment = paletteShader.GLSL_ES_Fragment.Content;
var oldPaletteLoop = "for(float i = corner.y; i < u_Uvs.w; i+=u_pixelSize.y )";
if (!paletteFragment.Contains(oldPaletteLoop)) throw new Exception("调色板着色器结构不匹配");
paletteFragment = paletteFragment.Replace("precision mediump float;", "#ifdef GL_FRAGMENT_PRECISION_HIGH\nprecision highp float;\n#else\nprecision mediump float;\n#endif");
paletteFragment = paletteFragment.Replace(oldPaletteLoop + "\r\n    {", "for(int hd_row = 0; hd_row < 256; hd_row++)\n    {\n        float i = corner.y + float(hd_row) * u_pixelSize.y;\n        if (u_pixelSize.y <= 0.0 || i >= u_Uvs.w) break;");
paletteFragment = paletteFragment.Replace(oldPaletteLoop + "\n    {", "for(int hd_row = 0; hd_row < 256; hd_row++)\n    {\n        float i = corner.y + float(hd_row) * u_pixelSize.y;\n        if (u_pixelSize.y <= 0.0 || i >= u_Uvs.w) break;");
if (paletteFragment.Contains(oldPaletteLoop) || !paletteFragment.Contains("hd_row")) throw new Exception("调色板循环替换失败");
paletteShader.GLSL_ES_Fragment = Data.Strings.MakeString(paletteFragment);
var root = Environment.GetEnvironmentVariable("HD_ANDROID_PROJECT");
if (String.IsNullOrEmpty(root)) throw new Exception("缺少安卓项目目录。");
var registration = new CodeImportGroup(Data);
var gameFunctions = GetDecompiledText("gml_GlobalScript_scr_game_functions");
var mobileFunctions = File.ReadAllText(Path.Combine(root,"src", Environment.GetEnvironmentVariable("HD_ANDROID_LANGUAGE") == "en" ? "触屏控制-en.gml" : "触屏控制.gml"));
registration.QueueReplace("gml_GlobalScript_scr_game_functions", gameFunctions + "\n" + mobileFunctions);
var imported = registration.Import();
if (!imported.Successful) throw new Exception(imported.PrintAllErrors(false));
var group = new CodeImportGroup(Data);
int changed = 0;
foreach (var code in Data.Code.Where(c => c.ParentEntry == null).ToList()) {
    string name = code.Name.Content;
    if (name.StartsWith("gml_GlobalScript_GMLive")) continue;
    string source = name == "gml_GlobalScript_scr_game_functions" ? gameFunctions : GetDecompiledText(name);
    string original = source;
    // 正式安卓测试包不启动开发者热重载对象，避免每秒尝试连接本机调试服务。
    if (name.StartsWith("gml_Object_obj_gmlive_")) source = "// 安卓关闭开发热重载。\n";
    // Windows Steam 扩展不能在安卓加载；保留游戏内成就与本地 MOD 逻辑。
    source = Regex.Replace(source, @"\bsteam_[A-Za-z0-9_]+(?=\s*\()", "scr_hd_no_steam");
    // 触屏按钮与硬件键盘共用原版快捷键分支；指针按实际显示区域映射，兼容拉伸。
    source = Regex.Replace(source, @"\bkeyboard_check_pressed(?=\s*\()", "scr_hd_key_pressed");
    source = Regex.Replace(source, @"\bkeyboard_check_released(?=\s*\()", "scr_hd_key_released");
    source = Regex.Replace(source, @"\bkeyboard_check(?=\s*\()", "scr_hd_key_held");
    source = Regex.Replace(source, @"\bmouse_x\b", "scr_hd_mouse_x()");
    source = Regex.Replace(source, @"\bmouse_y\b", "scr_hd_mouse_y()");
    source = Regex.Replace(source, @"\bwindow_set_size\([^;]*\);", "// 安卓使用设备实际绘制区域。\n");
    source = source.Replace("window_center();", "// 安卓无需桌面窗口居中。\n");
    if (name == "gml_GlobalScript_scr_game_functions") {
        source = source.Replace("function scr_get_input()\n{", "function scr_get_input()\n{\n    scr_hd_mobile_input();");
        source = source.Replace("global.UI_TOGGLE = scr_hd_key_pressed(vk_enter);", "global.UI_TOGGLE = scr_hd_key_pressed(vk_enter); scr_hd_mobile_merge();");
        source = source.Replace("var d_mx = display_mouse_get_x();", "var d_mx = global.HD_CURSOR_X;");
        source = source.Replace("var d_my = display_mouse_get_y();", "var d_my = global.HD_CURSOR_Y;");
        source = source.Replace("if (scr_hd_key_held(vk_escape))", "if (scr_hd_key_held(vk_escape) || global.HD_BACK)");
        source = source.Replace("if (scr_hd_key_pressed(ord(\"Z\")))", "if (scr_hd_key_pressed(ord(\"Z\")) || global.HD_ZOOM_P)");
        source = source.Replace("global.GAME_SCALE = sca;", "global.GAME_SCALE = sca; if (sca < 4) { global.HD_AUTO_RES = false; global.GAME_RES = sca; }");
        source = source.Replace("global.GAME_RES = sca;", "global.GAME_RES = sca; global.HD_AUTO_RES = false;");
        source = source.Replace("global.HI_REFRESH_RATE = !global.HI_REFRESH_RATE;", "global.HI_REFRESH_RATE = !global.HI_REFRESH_RATE; scr_update_display();");
        source += "\n" + mobileFunctions;
    }
    if (name == "gml_Object_sys_game_Draw_77") {
        var start = source.IndexOf("var width_mult =");
        var end = source.IndexOf("global.LV_COLORS_ALTERED =");
        if (start < 0 || end < start) throw new Exception("r44最终画面结构不匹配");
        source = source.Substring(0,start) + "scr_hd_mobile_view();\ndraw_surface_stretched(application_surface,global.HD_VIEW_X,global.HD_VIEW_Y,global.HD_VIEW_W,global.HD_VIEW_H);\n" + source.Substring(end);
        source = source.Replace("draw_surface_ext(application_surface, xoffset * 0.5, yoffset * 0.5, sca / global.GAME_RES, sca / global.GAME_RES, 0, c_white, 1);", "draw_surface_stretched(application_surface,global.HD_VIEW_X,global.HD_VIEW_Y,global.HD_VIEW_W,global.HD_VIEW_H);");
    }
    if (name == "gml_Object_sys_game_Draw_64") source += "\nscr_hd_mobile_draw();\n";
    if (name == "gml_GlobalScript_scr_gui_functions") source = source.Replace("string_delete(global.DIALOGUE_STRING, global.DIALOGUE_CUR_CHAR, string_length(global.DIALOGUE_STRING))", "string_copy(global.DIALOGUE_STRING, 1, max(0, floor(global.DIALOGUE_CUR_CHAR) - 1))");
    if (name == "gml_Object_obj_title_Other_11") source = "// 安卓版本不进入 Steam 工坊上传界面。\n";
    if (name == "gml_GlobalScript_scr_modding_functions") source = source.Replace("\\\\", "/");
    if (name == "gml_GlobalScript_scr_system_functions") {
        source = source.Replace("if (global.OPT_FULLSCREEN)", "scr_hd_mobile_init(); if (!global.HD_AUTO_RES) global.HD_MANUAL_RES = global.GAME_RES; global.OPT_FULLSCREEN = true; scr_hd_mobile_view(); scr_hd_mobile_save_display(); if (global.OPT_FULLSCREEN)");
        source = source.Replace("display_reset(0, global.OPT_VSYNC);", "// 安卓由运行器管理显示刷新。\n");
    }
    if (source != original) { group.QueueReplace(name, source); changed++; }
}
var result = group.Import();
if (!result.Successful) throw new Exception(result.PrintAllErrors(false));
foreach (var extension in Data.Extensions.Where(e => e.Name.Content == "Steamworks").ToList()) Data.Extensions.Remove(extension);
// 安卓运行器在载入资源时会解析整个函数表，未被调用的 Steam 符号也必须清除。
foreach (var function in Data.Functions.Where(f => f.Name.Content.StartsWith("steam_")).ToList()) Data.Functions.Remove(function);
ScriptMessage("安卓适配完成："+changed+"个代码项；ARM64 原生运行器，触屏控制，禁用 Windows Steam 扩展。");
