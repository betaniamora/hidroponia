<?php

/**
 * AUTOR:  RODRIGO PORTILLO
 * CORREO: rodrigoivanportillob@gmail.com
 * AÑO: 2020
 */
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// get database connection
include_once '../config/database.php';
include_once '../objects/login.php';

$database = new Database();
$db = $database->getConnection();
// instantiate user and consulta object
$login = new Login($db);

// get posted data
$data = json_decode(file_get_contents("php://input"));

// make sure data is not empty
if (
    !empty($data->user)         and
    !empty($data->pass)
) {

    // set user property values
    $login->user = $data->user;
    $login->pass = $data->pass;

    $autent = $login->validate();

    if (!empty($autent)) {
        if ($autent[0] == 1) {
            http_response_code(200);
            echo json_encode(array("code" => $autent[0], "message" => true, "data" => $autent[2]));
            exit;
        } else {
            http_response_code(400);
            echo json_encode(array("code" => $autent[0], "message" => $autent[1]));
            exit;
        }
    } else {
        http_response_code(400);
        echo json_encode(array("code" => "-999", "message" => "Error al autenticar usuario."));
        exit;
    }
} else {
    http_response_code(400);
    echo json_encode(array("code" => "-999", "message" => "Datos incompletos."));
    exit;
}
