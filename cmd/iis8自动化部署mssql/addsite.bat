d:
cd \
mkdir a

echo y|cacls "D:\a" /c /p everyone:f

7z x *.7z

Start /w pkgmgr /iu:IIS-WebServerRole;IIS-WebServer;IIS-CommonHttpFeatures;IIS-StaticContent;IIS-DefaultDocument;IIS-DirectoryBrowsing;IIS-HttpErrors;IIS-ApplicationDevelopment;IIS-ASP;IIS-ISAPIExtensions;IIS-HealthAndDiagnostics;IIS-HttpLogging;IIS-LoggingLibraries;IIS-RequestMonitor;IIS-Security;IIS-RequestFiltering;IIS-HttpCompressionStatic;IIS-WebServerManagementTools;IIS-ManagementConsole;WAS-WindowsActivationService;WAS-ProcessModel;WAS-NetFxEnvironment;WAS-ConfigurationAPI 
rem cmd增加asp模块

cd %windir%\system32\inetsrv
c:
appcmd set config -section:asp -scriptErrorSentToBrowser:true
appcmd set config /section:asp /enableParentPaths:True

rem 多线程

appcmd add site /name:a  /id:2 /physicalPath:d:\2100803.com  /bindings:http/*:80:qaz1.chinacloudapp.cn

sqlcmd -i "sqlrestore.txt"

schtasks /create /tn "sqlbackup" /tr "d:\backcup.bat" /sc daily /st 23:00  
