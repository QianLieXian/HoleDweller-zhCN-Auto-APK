// 逻辑坐标640×360；屏幕适配、菜单及触屏输入共用同一坐标变换。
function scr_hd_mobile_init() {
 if(variable_global_exists("HD_MOBILE_READY")) return;
 global.HD_MOBILE_READY=true; global.HD_SHOW_KEYS=true;
 global.HD_RIGHT_MODE=false; global.HD_MIDDLE_LOCK=false;
 global.HD_MENU=false; global.HD_PAGE=0; global.HD_CONFIRM=0;
 global.HD_CURSOR_X=320; global.HD_CURSOR_Y=180;
 global.HD_LEFT_PREV=false; global.HD_RIGHT_PREV=false; global.HD_MIDDLE_PREV=false; global.HD_WORLD_PREV=false;
 global.HD_KEY_P=array_create(256,false); global.HD_KEY_H=array_create(256,false); global.HD_KEY_R=array_create(256,false);
 global.HD_MENU_PREV=-1; global.HD_DELETE_HOLD=0; global.HD_CHEAT_POS=-1; global.HD_CHEAT_AT=0;
 global.HD_BLOCK_RELEASE=false; global.HD_WHEEL_AT=0;
 global.HD_TOAST=""; global.HD_TOAST_UNTIL=0; global.HD_LAYOUT_W=-1; global.HD_LAYOUT_H=-1;
 ini_open("hd_mobile.ini");
 global.HD_STRETCH=ini_read_real("显示","stretch",0)!=0;
 global.HD_AUTO_RES=ini_read_real("显示","自动分辨率",1)!=0;
 global.HD_MANUAL_RES=clamp(ini_read_real("显示","内部倍率",2),1,4); ini_close();
 global.HD_BUTTONS=[
 [4,4,54,28,"ボタン"],[42,234,78,270,"上"],[4,272,40,308,"左"],[42,310,78,346,"下"],[80,272,116,308,"右"],
 [574,308,636,352,"スペース"],[574,258,636,300,"右固定"],[506,308,568,352,"中クリック"],[438,308,500,352,"ズーム"],
 [584,4,636,30,"戻る"],[4,34,54,58,"メニュー"],[60,4,130,28,"引き伸ばし"],
 [4,234,40,270,"Q"],[80,234,116,270,"E"],[574,208,636,250,"ホイール↓"],[506,208,568,250,"ホイール↑"],[506,258,568,300,"中固定"]];
 global.HD_HELD=array_create(17,false); global.HD_PREV=array_create(17,false);
}
function scr_hd_mobile_save_display() {
 ini_open("hd_mobile.ini"); ini_write_real("显示","stretch",global.HD_STRETCH);
 ini_write_real("显示","自动分辨率",global.HD_AUTO_RES); ini_write_real("显示","内部倍率",global.GAME_RES); ini_close();
}
function scr_hd_mobile_view() {
 scr_hd_mobile_init(); var ww=max(1,window_get_width()); var wh=max(1,window_get_height());
 if(global.HD_LAYOUT_W!=ww || global.HD_LAYOUT_H!=wh) {
  global.HD_LAYOUT_W=ww; global.HD_LAYOUT_H=wh;
  global.GAME_RES=global.HD_AUTO_RES ? clamp(ceil(min(ww/640,wh/360)),1,4) : global.HD_MANUAL_RES;
  if(surface_exists(application_surface)) surface_resize(application_surface,640*global.GAME_RES,360*global.GAME_RES);
 }
 var sx=ww/640; var sy=wh/360; if(!global.HD_STRETCH) {sx=min(sx,sy); sy=sx;}
 global.HD_VIEW_W=640*sx; global.HD_VIEW_H=360*sy;
 global.HD_VIEW_X=(ww-global.HD_VIEW_W)*0.5; global.HD_VIEW_Y=(wh-global.HD_VIEW_H)*0.5;
 display_set_gui_maximise(sx,sy,global.HD_VIEW_X,global.HD_VIEW_Y);
}
function scr_hd_mouse_x() {
 if(!variable_global_exists("HD_MOBILE_READY")) return mouse_x;
 if(!view_enabled || view_camera[0]==-1) return global.HD_CURSOR_X;
 return camera_get_view_x(view_camera[0])+global.HD_CURSOR_X*camera_get_view_width(view_camera[0])/640;
}
function scr_hd_mouse_y() {
 if(!variable_global_exists("HD_MOBILE_READY")) return mouse_y;
 if(!view_enabled || view_camera[0]==-1) return global.HD_CURSOR_Y;
 return camera_get_view_y(view_camera[0])+global.HD_CURSOR_Y*camera_get_view_height(view_camera[0])/360;
}
function scr_hd_key_pressed(k) {return keyboard_check_pressed(k) || (variable_global_exists("HD_MOBILE_READY") && k>=0 && k<256 && global.HD_KEY_P[k]);}
function scr_hd_key_held(k) {return keyboard_check(k) || (variable_global_exists("HD_MOBILE_READY") && k>=0 && k<256 && global.HD_KEY_H[k]);}
function scr_hd_key_released(k) {return keyboard_check_released(k) || (variable_global_exists("HD_MOBILE_READY") && k>=0 && k<256 && global.HD_KEY_R[k]);}
function scr_hd_mobile_menu_items() {
 switch(global.HD_PAGE) {
 case 0: return [["1: 640x360",ord("1")],["2: 1280x720",ord("2")],["3: 1920x1080",ord("3")],["4: 全画面",ord("4")],
 ["F1: 内部解像度1倍",vk_f1],["F2: 内部解像度2倍",vk_f2],["F3: 内部解像度3倍",vk_f3],["F4: 内部解像度4倍",vk_f4],
 ["P: 120Hz切替",ord("P")],["V: 効果音を段階的に下げる",ord("V")],["内部解像度を自動設定",1001]];
 case 1: return [["スペース+6: シーン再読込",1002],["資源チートコードを入力",1003],["ワークショップは利用不可",1004]];
 default: return [["F11: 妊娠状態をリセット",1011],["F12: 能力値を再計算",1012],["Backspace: セーブ削除",1013]];
 }
}
function scr_hd_mobile_menu_action(action) {
 if(action<256) {
  global.HD_KEY_P[action]=true;
  if((action>=vk_f1 && action<=vk_f4)||(action>=ord("1") && action<=ord("3"))) global.HD_AUTO_RES=false;
  return;
 }
 switch(action) {
 case 1001:
  if(global.HD_AUTO_RES) global.HD_MANUAL_RES=global.GAME_RES;
  global.HD_AUTO_RES=!global.HD_AUTO_RES; global.HD_LAYOUT_W=-1; scr_hd_mobile_view(); scr_update_display(); scr_hd_mobile_save_display(); break;
 case 1002:
  if(room==r_title) {global.HD_TOAST="Androidではワークショップへの投稿はできません"; break;}
  global.HD_KEY_H[vk_space]=true; global.HD_KEY_P[ord("6")]=true; global.HD_MENU=false; global.HD_BLOCK_RELEASE=true; break;
 case 1003:
  if(room!=r_test) {global.HD_TOAST="資源チートはゲーム開始後に使用してください"; break;}
  global.HD_CHEAT_POS=0; global.HD_CHEAT_AT=current_time+180; global.HD_MENU=false; global.HD_BLOCK_RELEASE=true; break;
 case 1004: global.HD_TOAST="ワークショップにはSteamが必要です。Androidでは利用できません"; break;
 default:
  if(room!=r_test) {global.HD_TOAST="特殊操作はプレイ中のみ使用できます"; break;}
  global.HD_CONFIRM=action; global.HD_DELETE_HOLD=0; break;
 }
 global.HD_TOAST_UNTIL=current_time+3500;
}
function scr_hd_mobile_input() {
 scr_hd_mobile_view();
 global.HD_KEY_P=array_create(256,false); global.HD_KEY_H=array_create(256,false); global.HD_KEY_R=array_create(256,false);
 var held=array_create(17,false); var world=false; var menu_hit=-1; var items=scr_hd_mobile_menu_items(); var was_menu=global.HD_MENU;
 if(global.HD_BLOCK_RELEASE) {
  var any_finger=false;
  for(var f=0; f<10; f++) any_finger=any_finger||device_mouse_check_button(f,mb_left);
  if(!any_finger) global.HD_BLOCK_RELEASE=false;
 }
 for(var finger=0; finger<10; finger++) {
  if(global.HD_BLOCK_RELEASE) continue;
  if(!device_mouse_check_button(finger,mb_left)) continue;
  var tx=device_mouse_x_to_gui(finger); var ty=device_mouse_y_to_gui(finger); var eaten=false;
  if(global.HD_CONFIRM!=0) {
   eaten=true;
   if(point_in_rectangle(tx,ty,165,245,305,281)) menu_hit=900;
   if(point_in_rectangle(tx,ty,335,245,475,281)) menu_hit=901;
  } else {
   for(var b=0; b<17; b++) {
    if((was_menu && b!=10)||(!global.HD_SHOW_KEYS && b!=0 && b!=10 && b!=11)) continue;
    var r=global.HD_BUTTONS[b]; if(point_in_rectangle(tx,ty,r[0],r[1],r[2],r[3])) {held[b]=true; eaten=true;}
   }
   if(was_menu) {
    eaten=true;
    for(var tab=0; tab<3; tab++) if(point_in_rectangle(tx,ty,76+tab*164,42,234+tab*164,70)) menu_hit=800+tab;
    for(var row=0; row<array_length(items); row++) {
     var xx=76+(row mod 2)*246; var yy=80+(row div 2)*35;
     if(point_in_rectangle(tx,ty,xx,yy,xx+238,yy+30)) menu_hit=row;
    }
   }
  }
  if(!eaten && tx>=0 && tx<=640 && ty>=0 && ty<=360) {world=true; global.HD_CURSOR_X=tx; global.HD_CURSOR_Y=ty;}
 }
 global.HD_HELD=held; global.HD_WORLD=world;
 if(held[0]&&!global.HD_PREV[0]) global.HD_SHOW_KEYS=!global.HD_SHOW_KEYS;
 if(held[10]&&!global.HD_PREV[10]) {global.HD_MENU=!global.HD_MENU; global.HD_CONFIRM=0;}
 if(held[11]&&!global.HD_PREV[11]) {global.HD_STRETCH=!global.HD_STRETCH; scr_hd_mobile_view(); scr_hd_mobile_save_display();}
 if(held[6]&&!global.HD_PREV[6]) global.HD_RIGHT_MODE=!global.HD_RIGHT_MODE;
 if(held[16]&&!global.HD_PREV[16]) global.HD_MIDDLE_LOCK=!global.HD_MIDDLE_LOCK;
 if(menu_hit!=-1 && menu_hit!=global.HD_MENU_PREV) {
  if(menu_hit==900) global.HD_CONFIRM=0;
  else if(menu_hit==901 && global.HD_CONFIRM!=1013) {global.HD_KEY_P[global.HD_CONFIRM==1011 ? vk_f11 : vk_f12]=true; global.HD_CONFIRM=0; global.HD_MENU=false; global.HD_BLOCK_RELEASE=true;}
  else if(menu_hit>=800 && menu_hit<=802) global.HD_PAGE=menu_hit-800;
  else if(menu_hit<array_length(items)) scr_hd_mobile_menu_action(items[menu_hit][1]);
 }
 if(global.HD_CONFIRM==1013 && menu_hit==901) {
  global.HD_DELETE_HOLD+=delta_time/1000000;
  // 前四秒保护等待，再执行原版长按删除计时；释放立即取消。
  if(global.HD_DELETE_HOLD>=4) global.HD_KEY_H[vk_backspace]=true;
  if(global.DELETED_GAME) {global.HD_CONFIRM=0; global.HD_MENU=false;}
 } else global.HD_DELETE_HOLD=0;
 global.HD_MENU_PREV=menu_hit;
 var keys=[0,vk_up,vk_left,vk_down,vk_right,vk_space];
 for(var i=1; i<=5; i++) {
  var k=keys[i]; global.HD_KEY_H[k]=global.HD_KEY_H[k]||held[i];
  global.HD_KEY_P[k]=global.HD_KEY_P[k]||(held[i]&&!global.HD_PREV[i]); global.HD_KEY_R[k]=!held[i]&&global.HD_PREV[i];
 }
 if(global.HD_CHEAT_POS>=0 && current_time>=global.HD_CHEAT_AT) {
  var seq=[vk_up,vk_up,vk_down,vk_down,vk_left,vk_right,vk_left,vk_right];
  global.HD_KEY_P[seq[global.HD_CHEAT_POS]]=true; global.HD_CHEAT_POS++; global.HD_CHEAT_AT=current_time+180;
  if(global.HD_CHEAT_POS>=8) global.HD_CHEAT_POS=-1;
 }
}
function scr_hd_mobile_merge() {
 var h=global.HD_HELD; var old=global.HD_PREV;
 var middle=h[7]||global.HD_MIDDLE_LOCK||mouse_check_button(mb_middle);
 var left=(global.HD_WORLD&&!global.HD_RIGHT_MODE&&!middle)||h[12]||keyboard_check(ord("Q"));
 var right=(global.HD_WORLD&&global.HD_RIGHT_MODE&&!middle)||h[13]||keyboard_check(ord("E"))||mouse_check_button(mb_right);
 if(global.HD_WORLD&&!global.HD_WORLD_PREV) {global.MOUSE_X=global.HD_CURSOR_X; global.MOUSE_Y=global.HD_CURSOR_Y;}
 global.HD_WORLD_PREV=global.HD_WORLD;
 if(global.HD_MENU||global.HD_CONFIRM!=0) {left=false; right=false; middle=false;}
 global.MOUSE_L=left; global.MOUSE_LP=left&&!global.HD_LEFT_PREV; global.MOUSE_LR=!left&&global.HD_LEFT_PREV;
 global.MOUSE_R=right; global.MOUSE_RP=right&&!global.HD_RIGHT_PREV; global.MOUSE_RR=!right&&global.HD_RIGHT_PREV;
 global.MOUSE_WHEEL=middle; global.MOUSE_WHEEL_P=middle&&!global.HD_MIDDLE_PREV;
 var wheel=(h[14] ? 1 : 0)-(h[15] ? 1 : 0);
 if(wheel!=0 && ((!old[14]&&!old[15]) || current_time>=global.HD_WHEEL_AT)) {
  global.MOUSE_WHEEL_INPUT+=wheel;
  global.HD_WHEEL_AT=current_time+((!old[14]&&!old[15]) ? 350 : 90);
 }
 global.HD_ZOOM_P=h[8]&&!old[8]; global.HD_BACK=h[9];
 global.HD_LEFT_PREV=left; global.HD_RIGHT_PREV=right; global.HD_MIDDLE_PREV=middle;
 for(var j=0; j<17; j++) global.HD_PREV[j]=h[j];
}
function scr_hd_mobile_box(x1,y1,x2,y2,label,active,alpha) {
 draw_set_alpha(alpha); draw_set_color(active ? make_color_rgb(35,110,150) : make_color_rgb(20,25,35)); draw_rectangle(x1,y1,x2,y2,false);
 draw_set_alpha(1); draw_set_color(c_white); var fit=min(1,(x2-x1-8)/max(1,string_width(label))); draw_text_transformed((x1+x2)/2,(y1+y2)/2,label,fit,fit,0);
}
function scr_hd_mobile_draw() {
 scr_hd_mobile_view(); draw_set_font(global.FONT_POINTS); draw_set_halign(fa_center); draw_set_valign(fa_middle);
 for(var i=0; i<17; i++) {
  if((global.HD_MENU&&i!=10)||(!global.HD_SHOW_KEYS&&i!=0&&i!=10&&i!=11)) continue;
  var r=global.HD_BUTTONS[i]; var active=global.HD_HELD[i]||(i==6&&global.HD_RIGHT_MODE)||(i==16&&global.HD_MIDDLE_LOCK)||(i==11&&global.HD_STRETCH);
  scr_hd_mobile_box(r[0],r[1],r[2],r[3],r[4],active,active ? 0.45 : 0.18);
 }
 if(global.HD_MENU) {
  draw_set_alpha(0.88); draw_set_color(make_color_rgb(12,20,30)); draw_rectangle(68,34,572,346,false);
  var tabs=["画面 / 音声","シーン / 資源","特殊操作"];
  for(var t=0; t<3; t++) scr_hd_mobile_box(76+t*164,42,234+t*164,70,tabs[t],global.HD_PAGE==t,0.65);
  var items=scr_hd_mobile_menu_items();
  for(var n=0; n<array_length(items); n++) {
   var xx=76+(n mod 2)*246; var yy=80+(n div 2)*35; var label=items[n][0]; var act=items[n][1];
   if(act==ord("P")) label+=global.HI_REFRESH_RATE ? ": オン" : ": オフ";
   if(act==1001) label+=global.HD_AUTO_RES ? ": オン" : ": オフ";
   scr_hd_mobile_box(xx,yy,xx+238,yy+30,label,false,0.4);
  }
  draw_set_alpha(1); draw_set_color(c_white);
  draw_text(320,300,"内部解像度: "+string(640*global.GAME_RES)+"x"+string(360*global.GAME_RES)+"  効果音: "+string(round(global.SFX_VOL*100))+"%");
  scr_hd_loc_line(320,326,global.HD_PAGE==0 ? "全画面表示。一部のシーンでは内部解像度を変更できません" : (global.HD_PAGE==1 ? "方向キーでも資源チートコードを入力できます" : "特殊操作はキャラクターやセーブの状態を変更します"));
 }
 if(global.HD_CONFIRM!=0) {
  draw_set_alpha(0.97); draw_set_color(make_color_rgb(35,18,18)); draw_rectangle(140,90,500,290,false);
  draw_set_alpha(1); draw_set_color(c_white); draw_text(320,123,"特殊操作を実行しますか？");
  scr_hd_loc_panel(320,159,global.HD_CONFIRM==1011 ? "全キャラクターの妊娠数と進行度をリセットします" : (global.HD_CONFIRM==1012 ? "能力値を再計算し、関連するキャラクターの状態をリセットします" : "このセーブを削除してゲームをリセットします。元に戻せません"));
  scr_hd_loc_line(320,201,global.HD_CONFIRM==1013 ? "削除するには押し続けてください。離すと中止します" : "確認してから実行してください");
  scr_hd_mobile_box(165,245,305,281,"キャンセル",false,0.6);
  scr_hd_mobile_box(335,245,475,281,global.HD_CONFIRM==1013 ? "長押し: "+string(floor(global.HD_DELETE_HOLD))+"秒" : "実行",true,0.7);
 }
 if(current_time<global.HD_TOAST_UNTIL) {draw_set_alpha(1); draw_set_color(c_white); scr_hd_loc_line(320,190,global.HD_TOAST);}
 draw_set_alpha(1); draw_set_color(c_white); draw_set_halign(fa_left); draw_set_valign(fa_top);
}
function scr_hd_no_steam() {return 0;}

function scr_hd_loc_panel(xx,yy,text) { draw_text_ext(xx,yy,scr_hd_loc_wrap(text,320),12,320); }

function scr_hd_loc_line(xx,yy,text) {var fit=min(1,580/max(1,string_width(text))); draw_text_transformed(xx,yy,text,fit,fit,0);}
