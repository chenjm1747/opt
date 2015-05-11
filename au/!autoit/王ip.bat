@echo off  
cls   
color 0A    
rem //设置变量     
set Nic="本地连接"   
rem //可以根据你的需要更改,     
set Addr=192.168.0.248  
set Mask=255.255.255.0  
set Gway=192.168.0.1  
set Dns1=192.168.0.1  
set Dns2=192.168.0.1  
echo     1 设置为静态IP     
echo     2 设置为动态IP     
echo     3 退出     
echo －－－请选择项目后回车     
set /p answer=     
if %answer%==1 goto 1     
if %answer%==2 goto 2     
if %answer%==3 goto 3     
:1     
echo 正在进行静态IP设置，请稍等...     
echo I P 地址 = %addr%     
echo 子网掩码 = %Mask%     
netsh interface ip set address name=%Nic% source=static addr=%addr% mask=%Mask% gateway=%Gway% gwmetric=1    
echo 首选 DNS = %Dns1%     
netsh interface ip set dns name=%Nic% source=static addr=%Dns1% register=PRIMARY     
echo 备用 DNS = %Dns2%     
netsh interface ip add dns name=%Nic% addr=%Dns2% index=2     
echo 全部设置完成!   
ipconfig /all   
pause     
goto end     
:2     
echo 正在进行动态IP设置，请稍等...     
echo. IP 地址正在从DHCP自动获取...     
netsh interface ip set address "本地连接" dhcp     
echo. DNS地址正在从DHCP自动获取...     
netsh interface ip set dns "本地连接" dhcp     
echo ----     
echo 全部设置完成!     
pause     
:3     
:end
pause >null  
