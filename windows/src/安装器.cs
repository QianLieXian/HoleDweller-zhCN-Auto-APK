using System;
using System.IO;
using System.IO.Compression;
using System.Security.Cryptography;
using System.Diagnostics;
using System.Windows.Forms;
using System.Text;

// 本项目自己的安装器。差分记录采用复制偏移、字节差值和追加字节，使用 GZip 压缩。
// 不访问存档，不联网，不注册服务或开机启动项。
class Installer
{
    static string Root = AppDomain.CurrentDomain.BaseDirectory;
    static string FontName;
    static string PatchName;
    static readonly string[] Languages = {"zh","pt","ru","es","de","ja","fr","ko","tr"};
    static string FontFor(string lang) { return "fusion-pixel-12px-monospaced-" + (lang=="zh"?"zh_hans":lang=="ja"?"ja":lang=="ko"?"ko":"latin") + ".ttf"; }
    static string Detect(byte[] current) {
        foreach(string lang in Languages) using(var r=new BinaryReader(File.OpenRead(Path.Combine(Root,"patch",lang+".hdp")))) {
            r.ReadBytes(8); r.ReadBytes(32); if(Equal(Hash(current),r.ReadBytes(32))) return lang;
        }
        return null;
    }
    static byte[] Hash(byte[] bytes) { using (var sha = SHA256.Create()) return sha.ComputeHash(bytes); }
    static bool Equal(byte[] a, byte[] b) { if (a.Length != b.Length) return false; for (int i=0;i<a.Length;i++) if(a[i]!=b[i]) return false; return true; }
    static void Require(bool ok, string message) { if (!ok) throw new Exception(message); }
    static void AtomicWrite(string path, byte[] bytes)
    {
        string temp = path + ".zhCN.tmp";
        Require(!File.Exists(temp), "发现未完成的临时文件，请先检查：" + temp);
        try { File.WriteAllBytes(temp, bytes); File.Replace(temp, path, null); }
        finally { if (File.Exists(temp)) File.Delete(temp); }
    }
    static byte[] Apply(byte[] old, BinaryReader reader, long size, long count, long diffLength, long extraLength)
    {
        Require(size>0 && size<536870912 && count>=0 && count<10000000 && diffLength>=0 && extraLength>=0, "补丁头损坏。");
        byte[] payload;
        using(var zipped = new GZipStream(reader.BaseStream, CompressionMode.Decompress))
        using(var output = new MemoryStream()) { zipped.CopyTo(output); payload=output.ToArray(); }
        Require(payload.LongLength==checked(count*24+diffLength+extraLength), "补丁内容长度不符。");
        var result = new byte[(int)size];
        long oldPos=0,newPos=0,diffPos=count*24,extraPos=diffPos+diffLength;
        using(var records = new BinaryReader(new MemoryStream(payload)))
        for(long k=0;k<count;k++)
        {
            long x=records.ReadInt64(),y=records.ReadInt64(),z=records.ReadInt64();
            Require(x>=0 && y>=0 && x<=size-newPos && y<=size-newPos-x && x<=count*24+diffLength-diffPos && y<=payload.LongLength-extraPos, "差分记录越界。");
            for(long i=0;i<x;i++)
            {
                byte previous = oldPos+i>=0 && oldPos+i<old.LongLength ? old[(int)(oldPos+i)] : (byte)0;
                result[(int)(newPos+i)]=unchecked((byte)(previous+payload[(int)(diffPos+i)]));
            }
            newPos+=x;oldPos+=x;diffPos+=x;
            Buffer.BlockCopy(payload,(int)extraPos,result,(int)newPos,(int)y);
            newPos+=y;extraPos+=y;oldPos=checked(oldPos+z);
        }
        Require(newPos==size && diffPos==count*24+diffLength && extraPos==payload.LongLength, "补丁输出长度不符。");
        return result;
    }
    [STAThread]
    static int Main(string[] args)
    {
        Console.OutputEncoding = Encoding.UTF8;
        bool interactive=args.Length<2;
        try
        {
            string mode=args.Length>0?args[0]:"install";
            Require(mode=="install" || mode=="restore", "参数应为 install 或 restore。");
            string game;
            if(args.Length>=2) game=Path.GetFullPath(args[1]);
            else
            {
                using(var picker=new FolderBrowserDialog())
                {
                    picker.Description=mode=="restore"?"选择游戏目录，还原英文原版":"选择含 HoleDweller.exe 和 data.win 的游戏目录";
                    picker.SelectedPath=Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.ProgramFilesX86),"Steam","steamapps","common","Hole Dweller");
                    picker.ShowNewFolderButton=false;
                    if(picker.ShowDialog()!=DialogResult.OK) return 0;
                    game=picker.SelectedPath;
                }
            }
            Require(Process.GetProcessesByName("HoleDweller").Length==0, "请先退出游戏，再安装或还原。");
            string data=Path.Combine(game,"data.win"), backup=data+".zhCN.original";
            Require(File.Exists(data) && File.Exists(Path.Combine(game,"HoleDweller.exe")), "所选文件夹不是游戏安装目录。");
            string language=args.Length>2?args[2]:"zh";
            Require(Array.IndexOf(Languages,language)>=0,"Unknown language / 未知语言");
            string installed=Detect(File.ReadAllBytes(data));
            if(mode=="restore" && installed!=null) language=installed;
            if(mode=="install" && installed!=null && installed!=language) {
                var start=new ProcessStartInfo(Environment.GetCommandLineArgs()[0],"restore \""+game+"\" "+installed);
                start.UseShellExecute=false;
                using(var child=Process.Start(start)) { child.WaitForExit(); Require(child.ExitCode==0,"Restore failed; installation stopped / 还原失败，已停止切换语言"); }
            }
            FontName=FontFor(language); PatchName=language+".hdp";
            string font=Path.Combine(game,FontName), fontBackup=font+".zhCN.original", marker=Path.Combine(game,".hole-dweller-zhCN.state");
            byte[] sourceHash,targetHash; long size,count,dl,el;
            using(var patch=new BinaryReader(File.OpenRead(Path.Combine(Root,"patch",PatchName))))
            {
                Require(Equal(patch.ReadBytes(8),new byte[]{72,68,90,72,49,0,0,0}),"补丁格式不正确。");
                sourceHash=patch.ReadBytes(32);targetHash=patch.ReadBytes(32);
                size=patch.ReadInt64();count=patch.ReadInt64();dl=patch.ReadInt64();el=patch.ReadInt64();
                byte[] current=File.ReadAllBytes(data);
                if(mode=="restore")
                {
                    if(Equal(Hash(current),sourceHash)) { Console.WriteLine("当前已经是英文原版，无需还原。"); return 0; }
                    Require(Equal(Hash(current),targetHash), "当前文件含有其他修改，已停止还原，以免覆盖。");
                    Require(File.Exists(backup), "找不到原版备份，请通过 Steam 验证游戏文件。");
                    byte[] original=File.ReadAllBytes(backup);
                    Require(Equal(Hash(original),sourceHash), "原版备份校验失败，已停止还原。");
                    AtomicWrite(data,original);
                    if(File.Exists(marker))
                    {
                        string state=File.ReadAllText(marker);
                        byte[] expectedFont=Hash(File.ReadAllBytes(Path.Combine(Root,"assets",FontName)));
                        if(File.Exists(font) && Equal(Hash(File.ReadAllBytes(font)),expectedFont))
                        {
                            if(state=="added") File.Delete(font);
                            else if(state=="replaced" && File.Exists(fontBackup)) File.Copy(fontBackup,font,true);
                        }
                        File.Delete(marker);
                    }
                    Console.WriteLine("已恢复英文原版。存档未改动，原版备份保留在游戏目录。");
                }
                else
                {
                    if(Equal(Hash(current),targetHash)) { Console.WriteLine("当前已安装本版汉化，无需重复安装。"); return 0; }
                    Require(Equal(Hash(current),sourceHash), "Unsupported resources / 原版校验不匹配：仅支持指定 Steam Windows r44，请勿覆盖其他版本或模组。");
                    byte[] patched=Apply(current,patch,size,count,dl,el);
                    Require(Equal(Hash(patched),targetHash), "生成结果校验失败，游戏文件未改动。");
                    if(File.Exists(backup)) Require(Equal(Hash(File.ReadAllBytes(backup)),sourceHash), "已有原版备份校验不匹配，已停止安装。");
                    else File.WriteAllBytes(backup,current);
                    byte[] newFont=File.ReadAllBytes(Path.Combine(Root,"assets",FontName));
                    string state="added";
                    if(File.Exists(font))
                    {
                        if(Equal(Hash(File.ReadAllBytes(font)),Hash(newFont))) state="same";
                        else {
                            if(File.Exists(fontBackup)) Require(Equal(Hash(File.ReadAllBytes(font)),Hash(File.ReadAllBytes(fontBackup))),"Font backup mismatch / 已有字体备份与当前字体不一致，已停止。");
                            else File.Copy(font,fontBackup,false);
                            state="replaced";
                        }
                    }
                    File.Copy(Path.Combine(Root,"assets",FontName),font,true);
                    File.WriteAllText(marker,state);
                    AtomicWrite(data,patched);
                    Console.WriteLine("Windows localization 0.2.0 installed: "+language+". Original backed up; saves untouched / 原版已备份，存档未改动。");
                }
            }
            return 0;
        }
        catch(UnauthorizedAccessException) { Console.Error.WriteLine("目录没有写入权限。请右键安装或还原脚本，选择以管理员身份运行。"); return 1; }
        catch(Exception ex) { Console.Error.WriteLine("操作未完成："+ex.Message); return 1; }
        finally { if(interactive) { Console.WriteLine("按任意键关闭窗口。"); Console.ReadKey(); } }
    }
}
