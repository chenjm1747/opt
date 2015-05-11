Dim OpenParam(1)

'OpenOffice template file
TemplateFilePath = "file:///C:/Template.ots"

'OpenOffice saved file
strFileOut = "file:///C:/FinishedFile.ods"

Set objServiceManager= CreateObject("com.sun.star.ServiceManager")
Set Stardesktop= objServiceManager.createInstance("com.sun.star.frame.Desktop")

Set OpenParam(0) = MakePropertyValue("Hidden", TRUE) 'FALSE : affichage ¨¤ l'¨¦cran, TRUE : en cach¨¦

Set TemplateFile = Stardesktop.loadComponentFromURL(TemplateFilePath, "_blank", 0, Array(OpenParam(0)))

Set oSheet = TemplateFile.getSheets().getByIndex(0)             
oSheet.getCellRangeByName("A1").setFormula("your texte")

TemplateFile.storeToURL strFileOut,Array()

TemplateFile.Close(True)

Function MakePropertyValue(cName,uValue)
    Dim oStruct, oServiceManager 
    Set oServiceManager = CreateObject("com.sun.star.ServiceManager")
    Set oStruct = oServiceManager.Bridge_GetStruct("com.sun.star.beans.PropertyValue")
    oStruct.Name = cName
    oStruct.Value = uValue
    Set MakePropertyValue = oStruct
End Function