<?php


$host="localhost";

$user="root";

$pass="";

$db="api_demo";



$conn = new mysqli(
$host,
$user,
$pass,
$db
);



if($conn->connect_error){

die(
json_encode([
"success"=>false,
"message"=>"Database Error"
])
);

}



$conn->set_charset("utf8");


?>