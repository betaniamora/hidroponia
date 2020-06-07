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
    !empty($data->even) and $data->even != 'I' and
    !empty($data->esta) and
    !empty($data->obse) and
    !empty($data->cant) and
    !empty($data->fech_inic) and
    !empty($data->user) and
    !empty($data->conf_plan) and
    !empty($data->inve_codi)
) {
    http_response_code(400);
    echo json_encode(array("code" => "-999", "message" => "Datos incompletos."));
    exit;
}
if (
    $data->even != 'U' and
    (!empty($data->plant_codi) and $data->plant_codi == '') and
    !empty($data->esta) and
    !empty($data->obse) and
    !empty($data->cant) and
    !empty($data->user) and
    !empty($data->inve_codi)
) {
    http_response_code(400);
    echo json_encode(array("code" => "-999", "message" => "Para modificar debe insertar el id del registro"));
    exit;
}
// set user property values
$cosecha->even = !empty($data->even) ? $data->even : NULL;
$cosecha->esta = !empty($data->esta) ? $data->esta : NULL;
$cosecha->obse = !empty($data->obse) ? $data->obse : NULL;
$cosecha->cant = !empty($data->cant) ? $data->cant : NULL;
$cosecha->fech_inic = !empty($data->fech_inic) ? $data->fech_inic : NULL;
$cosecha->user = $data->user;
$cosecha->conf_plan = !empty($data->conf_plan) ? $data->conf_plan : NULL;
$cosecha->plant_codi = !empty($data->plant_codi) ? $data->plant_codi : NULL;
$cosecha->inve_codi = !empty($data->inve_codi) ? $data->inve_codi : NULL;

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
