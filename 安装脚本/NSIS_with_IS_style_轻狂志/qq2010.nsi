!include "MUI2.nsh"

!define /math WM_NOTIFY_OUTTER_NEXT ${WM_USER} + 0x8

!define APP_NAME "QQ2010"

Name "${APP_NAME}"
OutFile "${APP_NAME}.exe"
Caption "${APP_NAME} InstallShield Wizard"
InstallDir $TEMP
BrandingText "Install Shield"

!define MUI_ABORTWARNING

!define MUI_WELCOMEPAGE_TEXT "The InstallShield(R) Wizard will complete the installation of $(^Name) on your computer. To continue, click Next."
!define MUI_ABORTWARNING_TEXT "$\r$\nAre you sure to quit $(^Name) InstallShield(R) Wizard?$\t$\r$\n$\r$\n$\r$\n"
!define MUI_ABORTWARNING_CANCEL_DEFAULT

!define MUI_WELCOMEFINISHPAGE_BITMAP Binary.NewBinary5.bmp

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP Binary.NewBinary1.bmp

!define MUI_WELCOMEPAGE_TITLE "Welcome to $(^Name) InstallShield(R) Wizard"
!define MUI_FINISHPAGE_TITLE "InstallShield(R) Wizard Complete"

!define MUI_CUSTOMFUNCTION_ABORT onUserAbort

!define MUI_PAGE_CUSTOMFUNCTION_PRE SetFlagValue1
!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_CUSTOMFUNCTION_PRE SetFlagValue2
!insertmacro MUI_PAGE_LICENSE ${__FILE__}
!define MUI_PAGE_CUSTOMFUNCTION_PRE SetFlagValue3
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ChangeFinishText
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

Var Abort.Flag

Section Install

    SetDetailsPrint textonly
    DetailPrint 'Installing...'
    SetDetailsPrint listonly
    SetOutPath $INSTDIR
    Sleep 500
    Sleep 500
    Sleep 500

SectionEnd

Function SetFlagValue1

    StrCpy $R0 5

FunctionEnd

Function SetFlagValue2

    StrCpy $R0 4

FunctionEnd

Function SetFlagValue3

    StrCpy $R0 3

FunctionEnd

Function ChangeFinishText

    ${If} $Abort.Flag = 1
      ${NSD_SetText} $mui.FinishPage.Text "The InstallShield(R) Wizard was interrupted before $(^Name) could be completely installed.\
      The system has not been modified. To install this program at a later time, run the installation again.$\r$\n$\r$\n$\r$\n\
      Click finish to exit the wizard."
      GetDlgItem $0 $HWNDPARENT 2
      System::Call 'user32::DestroyWindow(ir0)'
      GetDlgItem $0 $HWNDPARENT 3
      System::Call 'user32::DestroyWindow(ir0)'
    ${EndIf}

FunctionEnd

Function .onInit

    StrCpy $Abort.Flag 0

FunctionEnd

Function onUserAbort

    StrCpy $Abort.Flag 1
    SendMessage $HWNDPARENT ${WM_NOTIFY_OUTTER_NEXT} $R0 ""
    Abort

FunctionEnd