"""Generate a distributable delta, never ship the input game files. Requires bsdiff4."""
import argparse,bz2,gzip,hashlib,struct,pathlib
import bsdiff4
def number(x):
 n=int.from_bytes(x,'little');return -(n&((1<<63)-1)) if n>>63 else n
def main():
 p=argparse.ArgumentParser();p.add_argument('original',type=pathlib.Path);p.add_argument('localized',type=pathlib.Path);p.add_argument('patch',type=pathlib.Path);a=p.parse_args()
 old,new=a.original.read_bytes(),a.localized.read_bytes()
 delta=bsdiff4.diff(old,new);assert bsdiff4.patch(old,delta)==new,'Roundtrip failed'
 cl,dl,n=[number(delta[i:i+8]) for i in (8,16,24)]
 controls=bz2.decompress(delta[32:32+cl]);diff=bz2.decompress(delta[32+cl:32+cl+dl]);extra=bz2.decompress(delta[32+cl+dl:])
 values=[number(controls[i:i+8]) for i in range(0,len(controls),8)]
 payload=b''.join(struct.pack('<q',x) for x in values)+diff+extra
 header=b'HDZH1\0\0\0'+hashlib.sha256(old).digest()+hashlib.sha256(new).digest()+struct.pack('<qqqq',n,len(values)//3,len(diff),len(extra))
 a.patch.parent.mkdir(parents=True,exist_ok=True);a.patch.write_bytes(header+gzip.compress(payload,compresslevel=9,mtime=0))
 print('PATCH_ROUNDTRIP_PASS',hashlib.sha256(new).hexdigest())
if __name__=='__main__':main()
