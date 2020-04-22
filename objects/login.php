<?php

/**
 * AUTOR:  RODRIGO PORTILLO
 * CORREO: rodrigoivanportillob@gmail.com
 * AÑO: 2020
 */
class Login
{
    //variable de conexion DB
    private $conn;
    //variables a usar
    public $user;
    public $pass;

    public $data;
    public $codResp;
    public $descResp;

    private $fila;
    private $res;
    private $row;
    private $rows = array();
    private $user_row = array();
    private $inve = array();
    private $modu = array();

    public function __construct(&$db)
    {
        $this->conn = $db;
    }

    public function validate()
    {
        //$sql = "CALL PA_DEVU_LOGIN('RPORTILLO','12345678', @CODI_RESP, @DESC_RESP)";
        $sql = "CALL PA_DEVU_LOGIN(?, ?, @CODI_RESP, @DESC_RESP);";
        $sql1 = "SELECT @CODI_RESP CODI, @DESC_RESP RESP;";
        $stmt = $this->conn->prepare($sql);

        //  Bind the input parameter
        mysqli_stmt_bind_param($stmt, 'ss', $this->user, $this->pass);

        $this->user = htmlspecialchars(strip_tags($this->user));
        $this->pass = htmlspecialchars(strip_tags(strval($this->pass)));

        try {
            if (!mysqli_stmt_execute($stmt)) {
                $data = array(0 => -999, 1 => utf8_encode($stmt->error));
            } else {
                do {
                    if ($this->res = $stmt->get_result()) {
                        $this->row = mysqli_fetch_all($this->res);
                        $this->user_row = [
                            "USER_CODI" => $this->row[0][0],
                            "USER_DESC" => utf8_encode($this->row[0][1]),
                        ];

                        foreach ($this->row as $in) {
                            array_push($this->inve, array(
                                "INVE_CODI" => $in[2],
                                "INVE_DESC" => utf8_encode($in[3]),
                            ));
                        }

                        foreach ($this->row as $in) {
                            array_push($this->modu, array(
                                "MODU_CODI" => $in[4],
                                "MODU_DESC" => utf8_encode($in[5]),
                            ));
                        }
                        mysqli_free_result($this->res);
                    }
                } while ($stmt->more_results() && $stmt->next_result());
                if ($this->res = $this->conn->query($sql1)) {
                    $this->fila = $this->res->fetch_assoc();
                }
                $info = array("USER" => $this->user_row, "INVE" => $this->inve, "MODU" => $this->modu);
                $data = array(0 => $this->fila['CODI'], 1 => $this->fila['RESP'], 2 => $info);
                return $data;
            }
        } catch (Exception $e) {
            $data = array(0 => -999, 1 => utf8_encode('Error: ' . $e));
            return $data;
            exit;
        }
    }
}
