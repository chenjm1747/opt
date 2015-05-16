$oMSSC = ObjCreate('ScriptControl')
$oMSSC.Language = 'JavaScript'
$oMSSC.AddCode('var a = ' & $json & ';')
ConsoleWrite('var a = {' & $json & '};')
$id = $oMSSC.Eval('a.id');age
$username = $oMSSC.Eval('a.username');age
$Password =$oMSSC.Eval('a.password');age
$innertext =$oMSSC.Eval('a.innertext');age
$xiaoqu =$oMSSC.Eval('a.xiaoqu')
$title =$oMSSC.Eval('a.title')
$area =$oMSSC.Eval('a.area')
$minprice =$oMSSC.Eval('a.minprice')
$phone =$oMSSC.Eval('a.phone')
$updated_at=$oMSSC.Eval('a.updated_at')
$aArray = StringRegExp($updated_at, '(.+?)T', 1)
$updated_at=$aarray[0]
;发布时间

$tupian =$oMSSC.Eval('a.tupian')