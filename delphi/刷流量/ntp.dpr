unit Unit2;
 
interface
 
uses Windows, Winsock;
 
type
  NTPPACKET = record
    li, vn, mode, stratum: Byte;
    root_delay, root_dispersion: LongInt;
    ref_id: array[0..3] of Byte;
    reftimestamphigh, reftimestamplow, oritimestamphigh,
      oritimestamplow, recvtimestamphigh, recvtimestamplow,
      trantimestamphigh, trantimestamplow: LongInt;
  end;
  //用于转换本机网络字节顺序;
  lr = packed record
    l1, l2, l3, l4: byte;
  end;
 
const
  maxint2 = 4294967296.0;
 
function getntptime: TDateTime;
 
implementation
 
function flip(var n: longint): longint; //网络字节顺序与本机字节顺序转换;
var
  n1, n2: lr;
begin
  n1 := lr(n);
  n2.l1 := n1.l4;
  n2.l2 := n1.l3;
  n2.l3 := n1.l2;
  n2.l4 := n1.l1;
  flip := longint(n2);
end;
 
function tzbias: double; // 获取本地时间区与UTC时间偏差;
var
  tz: TTimeZoneInformation;
begin
  GetTimeZoneInformation(tz);
  result := tz.Bias / 1440;
end;
 
function ntp2dt(nsec, nfrac: longint): TDatetime; //将NTP 时间戳(timestamp)格式转换成为DELPHI的 TDateTime 格式;
var
  d, d1: double;
begin
  d := nsec;
  if d < 0 then d := maxint2 + d - 1;
  d1 := nfrac;
  if d1 < 0 then d1 := maxint2 + d1 - 1;
  d1 := d1 / maxint2;
  d1 := trunc(d1 * 1000) / 1000;
  result := (d + d1) / 86400;
  result := result - tzbias + 2;
end;
 
function getntptime: TDateTime; //主程序
var
  WSAData: TWSAData;
  skt: TSocket;
  addr: TSockAddrIn;
  n: integer;
  ntppack: NTPPACKET;
begin
  Result := 0;
  WSAStartup($0101, WSAData);
  skt := Socket(PF_INET, SOCK_DGRAM, IPPROTO_IP); //注意
  if skt = INVALID_SOCKET then
  begin
    Exit;
  end;
  ntppack.li := $1B;    //必须是1B,NTP协议如此
  ntppack.vn := 0;
  ntppack.mode := 0;
  ntppack.stratum := 0;
  addr.sin_family := PF_INET; //注意
  addr.sin_port := htons(123);
  addr.sin_addr.S_addr := inet_addr(inet_ntoa(Pinaddr(gethostbyname('ntp.sjtu.edu.cn')^.h_addr_list^)^));
  if sendto(skt, ntppack, SizeOf(ntppack), 0, addr, SizeOf(addr)) = -1 then
  begin
    closesocket(skt);
    WSACleanup;
  end;
  n := SizeOf(addr);
  if Recvfrom(skt, ntppack, SizeOf(ntppack), 0, addr, n) > 0 then
  begin
    result := ntp2dt(flip(ntppack.trantimestamphigh), flip(ntppack.trantimestamplow)); //将收到的数据报时间格式转换为本机时间;
  end;
  closesocket(skt);
  WSACleanup;
end;
end.
