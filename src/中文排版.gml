// 中文显示名仅用于绘制，保留存档和模组中的原始角色标识。
function scr_zh_display_names(_text)
{
    var _names = ["Cami", "Zaria", "Lia", "Kinwa", "Talia", "Silvia", "Oriana", "Druaga", "Nav", "Options", "Progress", "Character", "DAY"];
    var _zh = ["卡米", "扎莉娅", "莉娅", "金瓦", "塔莉娅", "希尔维娅", "奥莉安娜", "德鲁阿加", "娜芙", "设置", "进度", "角色", "天"];
    var _result = string(_text);
    for (var _i = 0; _i < array_length(_names); _i++)
    {
        if (_result == _names[_i]) return _zh[_i];
        if (string_pos(_names[_i], _result) == 1 && string_length(_result) > string_length(_names[_i]))
        {
            var _next = string_ord_at(_result, string_length(_names[_i]) + 1);
            if (_next >= 11904 || _next == 32) return _zh[_i] + string_delete(_result, 1, string_length(_names[_i]));
        }
    }
    return _result;
}

function scr_zh_has_cjk(_text)
{
    for (var _i = 1; _i <= string_length(_text); _i++)
    {
        var _cp = string_ord_at(_text, _i);
        if (_cp >= 11904 && _cp <= 65535) return true;
    }
    return false;
}

// 原版换行依赖空格。中文按实际字宽换行，保留已有换行及标点。
function scr_zh_wrap(_text, _width)
{
    _text = scr_zh_display_names(_text);
    if (_width <= 0 || !scr_zh_has_cjk(_text)) return _text;
    var _result = "";
    var _line = "";
    var _closing = "，。！？；：、）》】」』…";
    for (var _i = 1; _i <= string_length(_text); _i++)
    {
        var _ch = string_char_at(_text, _i);
        if (_ch == "\n")
        {
            _result += _line + "\n";
            _line = "";
        }
        else if (_line != "" && string_width(_line + _ch) > _width && string_pos(_ch, _closing) == 0)
        {
            _result += _line + "\n";
            _line = _ch;
        }
        else _line += _ch;
    }
    return _result + _line;
}
