; 该脚本使用 HM VNISEdit 脚本编辑器向导产生
;!include dtgamework.nsh
; 安装程序初始定义常量
!define PRODUCT_NAME "搜狗高速浏览器"
!define PRODUCT_VERSION "2.0.0.1097"
!define PRODUCT_PUBLISHER "My company, Inc."
!define PRODUCT_WEB_SITE "http://www.mycompany.com"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define TEMP1 $R0 ;Temp variable
SetCompressor lzma
BrandingText "搜狗高速浏览器"
; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"

Var DLGITEM

ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"
ReserveFile "io.ini"

LangString PAGE_TITLE 2052 "选择附加任务"
LangString PAGE_SUBTITLE 2052 "选择执行搜狗高速浏览器安装程序后的一些附加任务。"


; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "sogou_explorer.ico"
!define MUI_UNICON "sogou_explorer.ico"


!define mui_headerimage
;!define mui_headerimage_right
!define mui_headerimage_bitmap "modern-header.bmp"

; 欢迎页面
!define mui_welcomepage_title '欢迎使用“搜狗高速浏览器\r\n2.0.0.1097”安装向导'
!define mui_welcomepage_text '这个向导将指引你完成“搜狗高速浏览器 2.0.0.1097”的安装进程。\r\n\r\n在开始安装之前，建议先关闭其他所有应用程序。这将\r\n允许“安装程序”更新指定的系统文件，而不需要重新启动你的计算机。\r\n\r\n单击 [下一步(N)] 继续。'
!define MUI_WELCOMEFINISHPAGE_BITMAP "modern-wizard.bmp"

;!define MUI_PAGE_CUSTOMFUNCTION_PRE WelcomePageSetupLinkPre
;!define MUI_PAGE_CUSTOMFUNCTION_SHOW WelcomePageSetupLinkShow

!insertmacro MUI_PAGE_WELCOME

!define mui_page_customfunction_show setcaption
!define mui_licensepage_text_top ""
!define mui_page_header_subtext '在安装“搜狗高速浏览器 2.0.0.1097”之前，请阅读授权$\r$\n协议。'
!insertmacro mui_page_license "license.txt"
; 安装目录选择页面
!define mui_page_header_text "请选择安装目录"
!define mui_page_header_subtext ""
!define mui_page_customfunction_show setcaption1
!insertmacro MUI_PAGE_DIRECTORY

Page custom component ;leave
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!define MUI_PAGE_CUSTOMFUNCTION_PRE WelcomePageSetupLinkPre
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ChageFONT
;!define mui_page_customfunction_leave ;leaves


!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"
VIProductVersion "2.0.0.1097"

VIAddVersionKey /LANG=2052 "ProductName" "Sogou Explorer"
VIAddVersionKey /LANG=2052 "Comments" "搜狗高速浏览器"
VIAddVersionKey /LANG=2052 "CompanyName" "Sogou.com"
VIAddVersionKey /LANG=2052 "LegalCopyright" "(C) Sogou.com Inc. All rights reserved."
VIAddVersionKey /LANG=2052 "FileDescription" "Sogou Explorer Setup"
VIAddVersionKey /LANG=2052 "FileVersion" "2.0.0.1097"
VIAddVersionKey /LANG=2052  "PrivateBuild" "000" ;个人内部本本说明
VIAddVersionKey /LANG=2052  "SpecialBuild" "3326" ;特殊内部本本说明

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "sogou_explorer_2.0.0.1097_3326.exe"
InstallDir "$PROGRAMFILES\My application"
ShowInstDetails hide
ShowUnInstDetails show
BrandingText "搜狗高速浏览器"





Section "MainSection" SEC01
;File "license.txt"
;Sleep 10000
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateDirectory "$SMPROGRAMS\My application"
  CreateShortCut "$SMPROGRAMS\My application\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\My application\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

/******************************
 *  以下是安装程序的卸载部分  *
 ******************************/
Function .onInit

  ;Extract InstallOptions files
  ;$PLUGINSDIR will automatically be removed when the installer closes

  InitPluginsDir
  File /oname=$PLUGINSDIR\io.ini "io.ini"
  FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"

  Delete "$SMPROGRAMS\My application\Uninstall.lnk"
  Delete "$SMPROGRAMS\My application\Website.lnk"

  RMDir "$SMPROGRAMS\My application"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
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
Function setcaption
SendMessage $hwndparent ${wm_settext} 0 "STR:搜狗高速浏览器 2.0.0.1097 安装：许可证协议"
FunctionEnd
Function setcaption1
SendMessage $hwndparent ${wm_settext} 0 "STR:搜狗高速浏览器 2.0.0.1097 安装：安装文件夹"
FunctionEnd
Function component
!insertmacro MUI_HEADER_TEXT $(PAGE_TITLE) $(PAGE_SUBTITLE)

 Push ${TEMP1}

    InstallOptions::dialog "$PLUGINSDIR\io.ini"
    Pop ${TEMP1}

  Pop ${TEMP1}
FunctionEnd
Function WelcomePageSetupLinkPre

!insertmacro MUI_INSTALLOPTIONS_READ $0 "ioSpecial.ini" "Settings" "Numfields"
IntOp $0 $0 + 8
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Settings" "Numfields" "$0"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 3" "Text" "搜狗高速浏览器 2.0.0.1097 已安装在你的系统。单击[关闭] 关闭此向导。"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 3" "Bottom" "65" ;修小原有的文字框，避免遮盖
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 4" "Type" "checkbox"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 4" "State" "1"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 4" "Text" "立即运行搜狗高速浏览器"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 4" "Left" "120"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 4" "Right" "262"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 4" "Top" "65"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 4" "Bottom" "85"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 5" "Type" "checkbox"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 5" "State" "0"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 5" "Text" "查看更新日志"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 5" "Left" "120"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 5" "Right" "262"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 5" "Top" "85"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 5" "Bottom" "105"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 6" "Type" "Label"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 6" "Text" "我们邀请您加入搜狗高速浏览器用户体验改进计划："
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 6" "Left" "120"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 6" "Right" "362"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 6" "Top" "110"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 6" "Bottom" "130"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 7" "Type" "Label"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 7" "Text" "通过您的参与，我们能够获取您的使用习惯信息并协$\r$\n助产品改进。我们不会获取任何隐私相关的信息或者影响您$\r$\n的正常使用。"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 7" "Left" "140"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 7" "Right" "362"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 7" "Top" "120"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 7" "Bottom" "130"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 8" "Type" "Label"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 8" "Text" "助产品改进。我们不会获取任何隐私相关的信息或者影响您"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 8" "Left" "120"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 8" "Right" "362"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 8" "Top" "130"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 8" "Bottom" "140"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 9" "Type" "Label"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 9" "Text" "的正常使用。"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 9" "Left" "120"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 9" "Right" "362"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 9" "Top" "140"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 9" "Bottom" "150"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 10" "Type" "Checkbox"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 10" "State" "0"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 10" "Text" "我愿意帮助改善搜狗告诉浏览器的产品体验"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 10" "Left" "120"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 10" "Right" "362"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 10" "Top" "155"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 10" "Bottom" "165"

!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 11" "Type" "label"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 11" "Text" "您可以随时在“帮助”菜单中选择退出计划。"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 11" "Left" "160"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 11" "Right" "362"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 11" "Top" "165"
!insertmacro MUI_INSTALLOPTIONS_WRITE "ioSpecial.ini" "Field 11" "Bottom" "175"

FunctionEnd
function ChageFONT
!insertmacro MUI_INSTALLOPTIONS_READ $DLGITEM "ioSpecial.ini" "Field 2" "HWND"

  CreateFont $1 "$(^Font)" "$(^FontSize)" "400"
SendMessage $DLGITEM ${WM_SETFONT} $1 1

GetDlgItem $0 $MUI_HWND 1203
SetCtlColors $0 "000000" "FFFFFF"

GetDlgItem $0 $MUI_HWND 1204
SetCtlColors $0 "000000" "FFFFFF"

GetDlgItem $0 $MUI_HWND 1205
SetCtlColors $0 "000000" "FFFFFF"

GetDlgItem $0 $MUI_HWND 1207
SetCtlColors $0 "000000" "FFFFFF"


GetDlgItem $0 $MUI_HWND 1208
SetCtlColors $0 "000000" "FFFFFF"


GetDlgItem $0 $MUI_HWND 1209
SetCtlColors $0 "000000" "FFFFFF"


GetDlgItem $0 $MUI_HWND 1210
SetCtlColors $0 "000000" "FFFFFF"


GetDlgItem $0 $MUI_HWND 1206
SetCtlColors $0 "000000" "FFFFFF"


GetDlgItem $0 $HWNDPARENT  1
SendMessage $0 ${WM_SETTEXT} $1 "STR:关闭"
functionend
;Function leaves
;MessageBox mb_ok "OVER"
;FunctionEnd
;Function leave
;messagebox MB_OK "leave"
;FunctionEnd
