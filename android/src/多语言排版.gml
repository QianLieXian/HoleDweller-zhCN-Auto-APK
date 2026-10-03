function scr_hd_loc_display(_text) {
 var _result=string(_text);
 var _names=global.HD_LOC_NAMES; var _values=global.HD_LOC_VALUES;
 for(var _i=0;_i<array_length(_names);_i++) {
  if(_result==_names[_i]) return _values[_i];
  if(_names[_i]=="Day" && string_pos("Day ",_result)==1) return _values[_i]+" "+string_delete(_result,1,4);
 }
 return _result;
}
function scr_hd_loc_wrap(_text,_width) {
 _text=scr_hd_loc_display(_text);
 if(_width<=0) return _text;
 var _has=false;
 for(var _i=1;_i<=string_length(_text);_i++) if(string_ord_at(_text,_i)>=11904) {_has=true; break;}
 if(!_has) return _text;
 var _out=""; var _line=""; var _closing="，。！？；：、）》】」』…。、？！)]}%";
 for(var _j=1;_j<=string_length(_text);_j++) {
  var _ch=string_char_at(_text,_j);
  if(_ch=="\n") {_out+=_line+"\n";_line="";}
  else if(_line!="" && string_width(_line+_ch)>_width && string_pos(_ch,_closing)==0) {_out+=_line+"\n";_line=_ch;}
  else _line+=_ch;
 }
 return _out+_line;
}
