<?php

/**
 * AUTOR:  RODRIGO PORTILLO
 * CORREO: rodrigoivanportillob@gmail.com
 * AÑO: 2020
 */
class Cosecha
{
    //variable de conexion DB
    private $conn;
    //variables a usar
    public $even;
    public $esta;
    public $obse;
    public $cant;
    public $fech_inic;
    public $user;
    public $conf_plan;
    public $plant_codi;
    public $inve_codi;

    public $data;
    public $codResp;
    public $descResp;

    private $fila;
    private $res;


    public function __construct(&$db)
    {
        $this->conn = $db;
    }

    public function POST()
    {
        $sql = "CALL PA_ABM_PLANT(?,?,?,?,?,?,?,?,?, @CODI_RESP, @DESC_RESP);";
        $sql1 = "SELECT @CODI_RESP CODI, @DESC_RESP RESP;";
        $stmt = $this->conn->prepare($sql);

        //  Bind the input parameter
        mysqli_stmt_bind_param(
            $stmt,
            'sssissiii',
            $this->even,
            $this->esta,
            $this->obse,
            $this->cant,
            $this->fech_inic,
            $this->user,
            $this->conf_plan,
            $this->plant_codi,
            $this->inve_codi
        );

        $this->even = htmlspecialchars(strip_tags($this->even));
        $this->esta = htmlspecialchars(strip_tags($this->esta));
        $this->obse = htmlspecialchars(strip_tags($this->obse));
        $this->cant = htmlspecialchars(strip_tags($this->cant));
        $this->fech_inic = htmlspecialchars(strip_tags($this->fech_inic));
        $this->user = htmlspecialchars(strip_tags($this->user));
        $this->conf_plan = htmlspecialchars(strip_tags($this->conf_plan));
        $this->plant_codi = htmlspecialchars(strip_tags($this->plant_codi));
        $this->inve_codi = htmlspecialchars(strip_tags($this->inve_codi));

        try {
            if (!mysqli_stmt_execute($stmt)) {
                $data = array(0 => -999, 1 => utf8_encode($stmt->error));
                return $data;
            } else {
                if ($this->res = $this->conn->query($sql1)) {
                    $this->fila = $this->res->fetch_assoc();
                }
                $data = array(0 => $this->fila['CODI'], 1 => $this->fila['RESP']);
                return $data;
            }
        } catch (Exception $e) {
            $data = array(0 => -999, 1 => utf8_encode('Error: ' . $e));
            return $data;
        }
    }
}
