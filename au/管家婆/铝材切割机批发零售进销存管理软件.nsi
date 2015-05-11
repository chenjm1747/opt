
; 安装程序初始定义常量
!define PRODUCT_NAME "铝材切割机批发零售进销存管理软件"
!define PRODUCT_VERSION "14.07.30"
!define PRODUCT_PUBLISHER "My company, Inc."
!define PRODUCT_WEB_SITE "http://www.mycompany.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\AppMainExe.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
SetCompressor /SOLID lzma
SetCompressorDictSize 32

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; 欢迎页面
!insertmacro MUI_PAGE_WELCOME
; 许可协议页面
!insertmacro MUI_PAGE_LICENSE "embedded\License.txt"
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!define MUI_FINISHPAGE_RUN "$INSTDIR\铝材切割机批发零售进销存管理软件.exe"
;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\embedded\InfoBefore.txt"
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Output\铝材切割机批发零售进销存管理软件.exe"
InstallDir "$PROGRAMFILES\铝材切割机批发零售进销存管理软件"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "aaaaaa"

Section "完整" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "管店婆(免费)\My.exe"
  Rename $INSTDIR\my.exe $INSTDIR\铝材切割机批发零售进销存管理软件.exe
  CreateDirectory "$SMPROGRAMS\铝材切割机批发零售进销存管理软件"
  CreateShortCut "$SMPROGRAMS\铝材切割机批发零售进销存管理软件\铝材切割机批发零售进销存管理软件.lnk" "$INSTDIR\铝材切割机批发零售进销存管理软件.exe"
  CreateShortCut "$DESKTOP\铝材切割机批发零售进销存管理软件.lnk" "$INSTDIR\铝材切割机批发零售进销存管理软件.exe"
  File "管店婆(免费)\data.dat.exe"
  File "管店婆(免费)\back.bmp"
  File "管店婆(免费)\Bmpcli32.dll"
  File "管店婆(免费)\ButtonSkin.dll"
  SetOutPath "$INSTDIR\data"
  File "管店婆(免费)\data\peijian.mdb"
  SetOutPath "$INSTDIR"
  File "管店婆(免费)\diskser.dll"
  File "管店婆(免费)\dw2xls.pbd"
  SetOutPath "$INSTDIR\images"
  File "管店婆(免费)\images\1.bmp"
  File "管店婆(免费)\images\101.bmp"
  File "管店婆(免费)\images\102.bmp"
  File "管店婆(免费)\images\123.jpg"
  File "管店婆(免费)\images\201.bmp"
  File "管店婆(免费)\images\202.bmp"
  File "管店婆(免费)\images\203.bmp"
  File "管店婆(免费)\images\204.bmp"
  File "管店婆(免费)\images\205.bmp"
  File "管店婆(免费)\images\206.bmp"
  File "管店婆(免费)\images\4.jpg"
  File "管店婆(免费)\images\403.bmp"
  File "管店婆(免费)\images\Background-4.jpg"
  File "管店婆(免费)\images\dl.bmp"
  File "管店婆(免费)\images\EXIT.BMP"
  File "管店婆(免费)\images\gys.bmp"
  File "管店婆(免费)\images\kh.bmp"
  File "管店婆(免费)\images\lb.bmp"
  File "管店婆(免费)\images\lb_add.bmp"
  File "管店婆(免费)\images\lb_del.bmp"
  File "管店婆(免费)\images\lb_hide.bmp"
  File "管店婆(免费)\images\lb_modify.bmp"
  File "管店婆(免费)\images\lb_refresh.bmp"
  File "管店婆(免费)\images\sp.bmp"
  File "管店婆(免费)\images\table_delete.bmp"
  File "管店婆(免费)\images\table_find.bmp"
  File "管店婆(免费)\images\tj.bmp"
  File "管店婆(免费)\images\xs.bmp"
  File "管店婆(免费)\images\xz.bmp"
  File "管店婆(免费)\images\yh.bmp"
  File "管店婆(免费)\images\人员管理.bmp"
  File "管店婆(免费)\images\协议.bmp"
  File "管店婆(免费)\images\客户.bmp"
  File "管店婆(免费)\images\提交.bmp"
  File "管店婆(免费)\images\核准.bmp"
  File "管店婆(免费)\images\货物.bmp"
  File "管店婆(免费)\images\进货订单.bmp"
  File "管店婆(免费)\images\销售.bmp"
  SetOutPath "$INSTDIR"
  File "管店婆(免费)\libjcc.dll"
  File "管店婆(免费)\libjsybheap.dll"
  File "管店婆(免费)\Md5.dll"
  File "管店婆(免费)\ntwdblib.DLL"
  File "管店婆(免费)\pbdwe90.dll"
  File "管店婆(免费)\pbmss90.dll"
  File "管店婆(免费)\pbodb90.dll"
  File "管店婆(免费)\pbvm90.dll"
  File "管店婆(免费)\pj.dll"
  File "管店婆(免费)\pj.pbd"
  File "管店婆(免费)\pjjxc.ini"
  File "管店婆(免费)\skinppwtl.dll"
  File "管店婆(免费)\total.pbd"
  File "管店婆(免费)\ttf16.ocx"
  File "管店婆(免费)\uo.pbd"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\铝材切割机批发零售进销存管理软件\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\铝材切割机批发零售进销存管理软件\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\AppMainExe.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\AppMainExe.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

/******************************
 *  以下是安装程序的卸载部分  *
 ******************************/

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\管店婆(免费).exe"
  Delete "$INSTDIR\图片加文字.au3"
  Delete "$INSTDIR\wxd_ll.bmp"
  Delete "$INSTDIR\wxd_add.bmp"
  Delete "$INSTDIR\wav\XOC.WAV"
  Delete "$INSTDIR\wav\TOCA.WAV"
  Delete "$INSTDIR\wav\system.wav"
  Delete "$INSTDIR\wav\peijian.mdb"
  Delete "$INSTDIR\wav\Notify.wav"
  Delete "$INSTDIR\wav\muff.wav"
  Delete "$INSTDIR\wav\msg.wav"
  Delete "$INSTDIR\wav\finish.wav"
  Delete "$INSTDIR\wav\error.wav"
  Delete "$INSTDIR\wav\close.WAV"
  Delete "$INSTDIR\wav\CHIMES.WAV"
  Delete "$INSTDIR\wav\Button.wav"
  Delete "$INSTDIR\wav\Blip.wav"
  Delete "$INSTDIR\uo.pbd"
  Delete "$INSTDIR\ttf16.ocx"
  Delete "$INSTDIR\total.pbd"
  Delete "$INSTDIR\skinppwtl.dll"
  Delete "$INSTDIR\skin\Royale.ssk"
  Delete "$INSTDIR\skin\PixOS.ssk"
  Delete "$INSTDIR\pjjxc.ini"
  Delete "$INSTDIR\pj.pbd"
  Delete "$INSTDIR\pj.dll"
  Delete "$INSTDIR\pbvm90.dll"
  Delete "$INSTDIR\pbodb90.dll"
  Delete "$INSTDIR\pbmss90.dll"
  Delete "$INSTDIR\pbdwe90.dll"
  Delete "$INSTDIR\ntwdblib.DLL"
  Delete "$INSTDIR\Md5.dll"
  Delete "$INSTDIR\logo.ico"
  Delete "$INSTDIR\Login.bmp"
  Delete "$INSTDIR\libjsybheap.dll"
  Delete "$INSTDIR\libjcc.dll"
  Delete "$INSTDIR\kp2003_2M.bmp"
  Delete "$INSTDIR\jxc.ico"
  Delete "$INSTDIR\images\销售.bmp"
  Delete "$INSTDIR\images\进货订单.bmp"
  Delete "$INSTDIR\images\货物.bmp"
  Delete "$INSTDIR\images\核准.bmp"
  Delete "$INSTDIR\images\提交.bmp"
  Delete "$INSTDIR\images\客户.bmp"
  Delete "$INSTDIR\images\协议.bmp"
  Delete "$INSTDIR\images\人员管理.bmp"
  Delete "$INSTDIR\images\yh.bmp"
  Delete "$INSTDIR\images\xz.bmp"
  Delete "$INSTDIR\images\xs.bmp"
  Delete "$INSTDIR\images\tj.bmp"
  Delete "$INSTDIR\images\table_find.bmp"
  Delete "$INSTDIR\images\table_delete.bmp"
  Delete "$INSTDIR\images\sp.bmp"
  Delete "$INSTDIR\images\lb_refresh.bmp"
  Delete "$INSTDIR\images\lb_modify.bmp"
  Delete "$INSTDIR\images\lb_hide.bmp"
  Delete "$INSTDIR\images\lb_del.bmp"
  Delete "$INSTDIR\images\lb_add.bmp"
  Delete "$INSTDIR\images\lb.bmp"
  Delete "$INSTDIR\images\kh.bmp"
  Delete "$INSTDIR\images\gys.bmp"
  Delete "$INSTDIR\images\EXIT.BMP"
  Delete "$INSTDIR\images\dl.bmp"
  Delete "$INSTDIR\images\Background-4.jpg"
  Delete "$INSTDIR\images\403.bmp"
  Delete "$INSTDIR\images\4.jpg"
  Delete "$INSTDIR\images\206.bmp"
  Delete "$INSTDIR\images\205.bmp"
  Delete "$INSTDIR\images\204.bmp"
  Delete "$INSTDIR\images\203.bmp"
  Delete "$INSTDIR\images\202.bmp"
  Delete "$INSTDIR\images\201.bmp"
  Delete "$INSTDIR\images\123.jpg"
  Delete "$INSTDIR\images\102.bmp"
  Delete "$INSTDIR\images\101.bmp"
  Delete "$INSTDIR\images\1.bmp"
  Delete "$INSTDIR\Icon_xp_083.ico"
  Delete "$INSTDIR\embedded\WizardSmallImage.bmp"
  Delete "$INSTDIR\embedded\WizardImage.bmp"
  Delete "$INSTDIR\embedded\License1.txt"
  Delete "$INSTDIR\embedded\License.txt"
  Delete "$INSTDIR\embedded\InfoBefore1.txt"
  Delete "$INSTDIR\embedded\InfoBefore.txt"
  Delete "$INSTDIR\embedded\demo.txt"
  Delete "$INSTDIR\embedded\chinesesimp.isl"
  Delete "$INSTDIR\dw2xls.pbd"
  Delete "$INSTDIR\diskser.dll"
  Delete "$INSTDIR\data\peijian.mdb"
  Delete "$INSTDIR\ButtonSkin.dll"
  Delete "$INSTDIR\Bmpcli32.dll"
  Delete "$INSTDIR\Background-4.jpg"
  Delete "$INSTDIR\back1.bmp"
  Delete "$INSTDIR\back.bmp"
  Delete "$INSTDIR\Arrow.bmp"
  Delete "$INSTDIR\Example.file"
  Delete "$INSTDIR\AppMainExe.exe"

  Delete "$SMPROGRAMS\铝材切割机批发零售进销存管理软件\Uninstall.lnk"
  Delete "$SMPROGRAMS\铝材切割机批发零售进销存管理软件\Website.lnk"
  Delete "$DESKTOP\铝材切割机批发零售进销存管理软件.lnk"
  Delete "$SMPROGRAMS\铝材切割机批发零售进销存管理软件\铝材切割机批发零售进销存管理软件.lnk"

  RMDir "$SMPROGRAMS\铝材切割机批发零售进销存管理软件"
  RMDir "$INSTDIR\wav"
  RMDir "$INSTDIR\skin"
  RMDir "$INSTDIR\images"
  RMDir "$INSTDIR\embedded"
  RMDir "$INSTDIR\data"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
FunctionEnd
