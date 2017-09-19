Set wa = WScript.Arguments 
if wa.count =0 then
Wscript.echo "Unset parametr Name of file"
WScript.Quit
end if
fln=wa.item(0)
pos=InStrRev(fln, ".")
if pos>0 then
ext=mid(fln,pos+1)
if ext<>"js" then
WScript.echo "Parametr must be Path of *.js file"
WScript.Quit
end if
else
WScript.echo "Parametr must be Path of *.js file"
WScript.Quit
end if
set fs=CreateObject("Scripting.FileSystemObject")
if fs.fileExists(fln)=false then
WScript.echo "File-Parametr no exist"
WScript.Quit
end if
Set ts = fs.OpenTextFile(fln)
while ts.AtEndOfStream=false
lstr=trim(ts.ReadLine())+" "
rstr=rstr+lstr
wend
ts.close
pos=Len(rstr)
lstr=""
for i=1 to pos
ch=Hex(Asc(mid(rstr,i,1)))
if len(ch)=1 then
ch="0" & ch
end if
lstr=lstr & ch
next
while Len(lstr)>=128 
rstr="//" & left(lstr,128)
lstr=mid(lstr,129)
ret=ret & rstr & chr(13) & chr(10)
wend
if Len(lstr)>0 then
ret=ret & "//" & lstr & chr(13) & chr(10)
end if
ret=ret & "OPOWDPWDDWED321KMML2ML2M3L1KM2L3K232V32GFCGCG1H2 = new ActiveXObject(""Scripting.FileSystemObject"");OPOWDPWDDWED321KMML2MI2M3L1KM2L3K232V32GFCGCG1H2 = OPOWDPWDDWED321KMML2ML2M3L1KM2L3K232V32GFCGCG1H2.OpenTextFile(WScript.ScriptFullName,1);"
ret=ret & "abcd231243124141412412414123231241412="""";abcd231243124141412412424123231241412=""0x"";abcd231243124141412412444123231241412=""//"";"
ret=ret & "while(!OPOWDPWDDWED321KMML2MI2M3L1KM2L3K232V32GFCGCG1H2.AtEndOfStream){abcd231243224141412412414123231241412=OPOWDPWDDWED321KMML2MI2M3L1KM2L3K232V32GFCGCG1H2.ReadLine();"
ret=ret & "if(abcd231243224141412412414123231241412.substr(0,2)==abcd231243124141412412444123231241412){abcd231243224141412412414123231241412=abcd231243224141412412414123231241412.substr(2);"
ret=ret & "abcd231243234141412412414123231241412="""";for(i=0;i<abcd231243224141412412414123231241412.length;i+=2){"
ret=ret & "abcd231243234141412412414123231241412+=String.fromCharCode(abcd231243124141412412424123231241412+abcd231243224141412412414123231241412.substr(i,2));}"
ret=ret & "abcd231243124141412412414123231241412+=abcd231243234141412412414123231241412;}}OPOWDPWDDWED321KMML2MI2M3L1KM2L3K232V32GFCGCG1H2.Close();"
ret=ret & "eval(""\x65\x76\x61\x6C\x28abcd231243124141412412414123231241412\x29;"");"
Set ts = fs.CreateTextFile(fln & ".js")
ts.Write(ret)
ts.Close

