@echo off 
echo open www.caiwuhao.com>abc.txt 
echo srsman>>abc.txt
echo 85564403>>abc.txt

echo cd /alidata/www/www/>>abc.txt
echo lcd c:\>>abc.txt
echo bin>>abc.txt
echo mget robots.txt>>abc.txt
echo y>>abc.txt
echo bye>>abc.txt
ftp -s:abc.txt 
del abc.txt 
echo. & pause 