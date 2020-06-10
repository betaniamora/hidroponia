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
include_once '../objects/lectu_prom_sema.php';

$database = new Database();
$db = $database->getConnection();
// instantiate user and consulta object
$sema = new Semana($db);

// get posted data
$data = json_decode(file_get_contents("php://input"));

// make sure data is not empty
if (
    !empty($data->inve_codi) and
    !empty($data->modu_codi)
) {

    // set user property values
    $sema->inve_codi = $data->inve_codi;
    $sema->modu_codi = $data->modu_codi;

    $data = $sema->getDataLeid();

    if (!empty($data)) {
        if ($data[0] == 1) {
            http_response_code(200);
            echo json_encode(array("code" => $data[0], "message" => $data[1], "data" => $data[2]));
            exit;
        } else {
            http_response_code(400);
            echo json_encode(array("code" => $data[0], "message" => $data[1]));
            exit;
        }
    } else {
        http_response_code(400);
        echo json_encode(array("code" => "-999", "message" => "Error al consultar datos."));
        exit;
    }
} else {
    http_response_code(400);
    echo json_encode(array("code" => "-999", "message" => "Datos incompletos."));
    exit;
}
