"""生成项目自有的 GZip 差分包。游戏原文件只在本地参与构建。"""
import argparse, bz2, gzip, hashlib, json, pathlib, struct
import bsdiff4

def read_number(data):
    value = int.from_bytes(data, 'little')
    return -(value & ((1 << 63) - 1)) if value >> 63 else value

def main():
    parser = argparse.ArgumentParser(description='生成汉化差分并验证还原结果')
    parser.add_argument('original', type=pathlib.Path)
    parser.add_argument('translated', type=pathlib.Path)
    parser.add_argument('project', type=pathlib.Path)
    args = parser.parse_args()
    original, translated = args.original.read_bytes(), args.translated.read_bytes()
    delta = bsdiff4.diff(original, translated)
    control_size, diff_size, output_size = [read_number(delta[i:i+8]) for i in (8, 16, 24)]
    controls = bz2.decompress(delta[32:32+control_size])
    differences = bz2.decompress(delta[32+control_size:32+control_size+diff_size])
    extra = bz2.decompress(delta[32+control_size+diff_size:])
    values = [read_number(controls[i:i+8]) for i in range(0, len(controls), 8)]
    payload = b''.join(struct.pack('<q', value) for value in values) + differences + extra
    original_hash, translated_hash = hashlib.sha256(original).digest(), hashlib.sha256(translated).digest()
    header = b'HDZH1\x00\x00\x00' + original_hash + translated_hash
    header += struct.pack('<qqqq', output_size, len(values)//3, len(differences), len(extra))
    if bsdiff4.patch(original, delta) != translated:
        raise RuntimeError('差分往返校验失败')
    (args.project / 'patch').mkdir(exist_ok=True)
    (args.project / 'patch' / '汉化补丁.hdp').write_bytes(header + gzip.compress(payload, compresslevel=9, mtime=0))
    info_path = args.project / '版本信息.json'
    info = json.loads(info_path.read_text(encoding='utf-8-sig'))
    info.update({'原版SHA256': original_hash.hex(), '汉化SHA256': translated_hash.hex(),
                 '原版大小': len(original), '汉化大小': len(translated),
                 '译文条数': len(json.loads((args.project/'src'/'译文.json').read_text(encoding='utf-8')))})
    info_path.write_text(json.dumps(info, ensure_ascii=False, indent=2), encoding='utf-8')
    print('差分生成成功，往返校验通过。')

if __name__ == '__main__':
    main()
