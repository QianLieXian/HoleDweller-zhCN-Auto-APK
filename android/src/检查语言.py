import json,re,sys,hashlib
from pathlib import Path
ROOT=Path(__file__).resolve().parent.parent
CAT=json.loads((ROOT/'locales/catalog.json').read_text(encoding='utf-8'))
def check(language):
 p=ROOT/'locales'/f'{language}.game.json'
 data=json.loads(p.read_text(encoding='utf-8'))
 missing=set(CAT)-set(data); extra=set(data)-set(CAT); errors=[]
 if missing or extra: errors.append(f'missing={len(missing)} extra={len(extra)}')
 for key,value in data.items():
  if key not in CAT: continue
  if not isinstance(value,str) or not value.strip(): errors.append(f'{key}: empty');continue
  spec=CAT[key]
  if sorted(re.findall(r'\{\d+(?::[^{}]+)?\}|%\d*\.?\d*[sdiuf]',value))!=sorted(spec['format_tokens']):errors.append(f'{key}: formatting tokens')
  if value.count('\n')!=spec['newlines']:errors.append(f'{key}: newline count')
  if spec['leading_space'] and not value.startswith(' '):errors.append(f'{key}: leading space')
  if spec['trailing_space'] and not value.endswith(' '):errors.append(f'{key}: trailing space')
  if 'numbers' in spec and sorted(re.findall(r'\d+(?:\.\d+)?',value))!=sorted(spec['numbers']):errors.append(f'{key}: numbers')
  if 'percent_count' in spec and value.count('%')!=spec['percent_count']:errors.append(f'{key}: percent count')
 if errors: raise ValueError(language+': '+', '.join(errors[:30]))
 return len(data)
if __name__=='__main__':
 for lang in sys.argv[1:]:print(lang,check(lang))
