<?php
$request = "https://api.kiwivm.it7.net/v1/snapshot/create?description=Automatic_Snapshot&veid=132122&api_key=private_zg8hzzRhMEdDIjgvVjQ0gFyJ";
$request = "https://api.kiwivm.it7.net/v1/snapshot/list?description=Automatic_Snapshot&veid=132122&api_key=private_zg8hzzRhMEdDIjgvVjQ0gFyJ";

$serviceInfo = json_decode (file_get_contents ($request));
//print_r($serviceInfo);
$deletefilename=$serviceInfo->snapshots[2]->fileName;
$file="http://104.194.76.26:8779/132122/".$deletefilename;
echo $deletefilename.$file;
$request = "https://api.kiwivm.it7.net/v1/snapshot/delete?snapshot=".$deletefilename."&veid=132122&api_key=private_zg8hzzRhMEdDIjgvVjQ0gFyJ";
//$file = file_get_contents($file);   
//file_put_contents("a.txt",$file); 

