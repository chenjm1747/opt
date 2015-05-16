#!/bin/bash
while : ;do
tail -n900 /usr/local/nginx/logs/www.mzmoeny.com_access.log|grep /sms/send.jspx|awk '{print $1 }'|sort|uniq -c|sort -rn|awk '{if ($1>0) print "deny " $2";"}'>/usr/local/nginx/conf/denyipone.conf
cat /usr/local/nginx/conf/denyipone.conf /usr/local/nginx/conf/denyip.conf > /usr/local/nginx/conf/denyiptwo.conf
cat /usr/local/nginx/conf/denyiptwo.conf|sort|uniq -c|awk '{print "deny "$3 }'>/usr/local/nginx/conf/denyip.conf



/usr/local/nginx/sbin/nginx -t

if [[ $? -eq 0 ]];then /usr/local/nginx/sbin/nginx -s reload ;fi
done
