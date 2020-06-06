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
include_once '../objects/cosecha.php';

$database = new Database();
$db = $database->getConnection();
// instantiate user and consulta object
$cosecha = new Cosecha($db);

// get posted data
$data = json_decode(file_get_contents("php://input"));

// make sure data is not empty
if (
    !empty($data->even) and
    !empty($data->esta) and
    !empty($data->obse) and
    !empty($data->fech_inic) and
    !empty($data->user) and
    !empty($data->conf_plan)
) {
    if ($data->even != 'I' and empty($data->hidro_codi)) {
        http_response_code(400);
        echo json_encode(array("code" => "-999", "message" => "Para modificar debe insertar el id del registro"));
        exit;
    }
    // set user property values
    $cosecha->even = $data->even;
    $cosecha->esta = $data->esta;
    $cosecha->obse = $data->obse;
    $cosecha->fech_inic = $data->fech_inic;
    $cosecha->user = $data->user;
    $cosecha->conf_plan = $data->conf_plan;
    $cosecha->hidro_codi = $data->hidro_codi;

    $data = $cosecha->POST();

    if (!empty($data)) {
        if ($data[0] == 1) {
            http_response_code(200);
            echo json_encode(array("code" => $data[0], "message" => $data[1]));
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
