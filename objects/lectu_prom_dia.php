<?php

/**
 * AUTOR:  RODRIGO PORTILLO
 * CORREO: rodrigoivanportillob@gmail.com
 * AÑO: 2020
 */
class Dia
{
    //variable de conexion DB
    private $conn;
    //variables a usar
    public $dia;
    public $modu_codi;
    public $inve_codi;

    public $data;
    public $codResp;
    public $descResp;

    private $fila;
    private $res;
    private $row;
    private $data_row = array();


    public function __construct(&$db)
    {
        $this->conn = $db;
    }

    public function getDataLeid()
    {
        $sql = "CALL PA_DEVU_DATA_MODU_DAY(?, ?, ?, @CODI_RESP, @DESC_RESP);";
        $sql1 = "SELECT @CODI_RESP CODI, @DESC_RESP RESP;";
        $stmt = $this->conn->prepare($sql);

        //  Bind the input parameter
        mysqli_stmt_bind_param($stmt, 'iii', $this->dia, $this->modu_codi, $this->inve_codi);

        $this->inve_codi = htmlspecialchars(strip_tags($this->inve_codi));
        $this->modu_codi = htmlspecialchars(strip_tags($this->modu_codi));
        $this->dia = htmlspecialchars(strip_tags($this->dia));

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
                            array_push($this->data_row, array(
                                "MODU_DESC" => utf8_encode($in[0]),
                                "TIPO_CODI" => $in[1],
                                "TIPO_DESC" => utf8_encode($in[2]),
                                "EQUI_MODEL" => utf8_encode($in[3]),
                                "DETA_VALUE_LEID" => $in[4],
                                "MEDI_DESC_ABRE" => $in[5],
                                "DETA_DATE_LEID" => $in[6],
                                "EQUI_INVE_CODI" => $in[7]
                            ));
                        }
                        mysqli_free_result($this->res);
                    }
                } while ($stmt->more_results() && $stmt->next_result());
                if ($this->res = $this->conn->query($sql1)) {
                    $this->fila = $this->res->fetch_assoc();
                }
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
