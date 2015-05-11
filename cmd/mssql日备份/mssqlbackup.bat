@echo off
d:
cd \
del /q d:\a\y.bak
del /q a.7z
sqlcmd -Q "BACKUP DATABASE ytaotaosoft to disk='d:\a\y.bak'"

7z a d:\a.7z d:\a
set filename=%date:~,4%%date:~5,2%%date:~8,2%_%time_hh%%time:~3,2%%time:~6,2%
pscp -P 22132 -pw "jmdjsj903291A"  a.7z root@sql.caiwuhao.com:/alidata/%filename%.7z
