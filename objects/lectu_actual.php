<?php

/**
 * AUTOR:  RODRIGO PORTILLO
 * CORREO: rodrigoivanportillob@gmail.com
 * AÑO: 2020
 */
class Actual
{
    //variable de conexion DB
    private $conn;
    //variables a usar
    public $inve_codi;

    public $data;
    public $codResp;
    public $descResp;

    private $fila;
    private $res;
    private $row;
    private $data_row = array();
    private $agua_row = array();
    private $clima_row = array();


    public function __construct(&$db)
    {
        $this->conn = $db;
    }

    public function getDataLeid()
    {
        //$sql = "CALL PA_DEVU_LOGIN('RPORTILLO','12345678', @CODI_RESP, @DESC_RESP)";
        $sql = "CALL PA_DEVU_DATA_MODU(?, @CODI_RESP, @DESC_RESP);";
        $sql1 = "SELECT @CODI_RESP CODI, @DESC_RESP RESP;";
        $stmt = $this->conn->prepare($sql);

        //  Bind the input parameter
        mysqli_stmt_bind_param($stmt, 'i', $this->inve_codi);

        $this->inve_codi = htmlspecialchars(strip_tags($this->inve_codi));

        try {
            if (!mysqli_stmt_execute($stmt)) {
                $data = array(0 => -999, 1 => utf8_encode($stmt->error));
                return $data;
                exit;
            } else {
                do {
                    if ($this->res = $stmt->get_result()) {
                        $this->row = mysqli_fetch_all($this->res);
                        foreach ($this->row as $in) {
                            if ($in[0] == 1) {
                                array_push($this->agua_row, array(
                                    "MODU_CODI" => $in[0],
                                    "MODU_DESC" => utf8_encode($in[1]),
                                    "TIPO_CODI" => $in[2],
                                    "TIPO_DESC" => utf8_encode($in[3]),
                                    "EQUI_CODI" => $in[4],
                                    "EQUI_MODEL" => utf8_encode($in[5]),
                                    "EQUI_UBIC" => utf8_encode($in[6]),
                                    "DETA_VALUE_LEID" => $in[7],
                                    "MEDI_DESC" => utf8_encode($in[8]),
                                    "MEDI_DESC_ABRE" => utf8_encode($in[9]),
                                    "DETA_DATE_LEID" => $in[10],
                                ));
                            } else if ($in[0] == 2) {
                                array_push($this->clima_row, array(
                                    "MODU_CODI" => $in[0],
                                    "MODU_DESC" => utf8_encode($in[1]),
                                    "TIPO_CODI" => $in[2],
                                    "TIPO_DESC" => utf8_encode($in[3]),
                                    "EQUI_CODI" => $in[4],
                                    "EQUI_MODEL" => utf8_encode($in[5]),
                                    "EQUI_UBIC" => utf8_encode($in[6]),
                                    "DETA_VALUE_LEID" => $in[7],
                                    "MEDI_DESC" => utf8_encode($in[8]),
                                    "MEDI_DESC_ABRE" => utf8_encode($in[9]),
                                    "DETA_DATE_LEID" => $in[10],
                                ));
                            }
                        }
                        mysqli_free_result($this->res);
                    }
                } while ($stmt->more_results() && $stmt->next_result());
                if ($this->res = $this->conn->query($sql1)) {
                    $this->fila = $this->res->fetch_assoc();
                }
                $this->data_row = array("AGUA" => $this->agua_row, "CLIMA" => $this->clima_row);
                $data = array(0 => $this->fila['CODI'], 1 => $this->fila['RESP'], 2 => $this->data_row);
                return $data;
            }
        } catch (Exception $e) {
            $data = array(0 => -999, 1 => utf8_encode('Error: ' . $e));
            return $data;
            exit;
        }
    }
}
