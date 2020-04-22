<?php

/**
 * AUTOR:  RODRIGO PORTILLO
 * CORREO: rodrigoivanportillob@gmail.com
 * AÑO: 2020
 */
class Database
{

    // specify your own database credentials
    private $host_db = '127.0.0.1';
    private $db_name = 'hidroponia';
    private $user = 'root';
    private $pass = '12345678';
    public $conn;

    // get the database connection
    public function getConnection()
    {
        $this->conn = null;
        try {
            $this->conn = new mysqli($this->host_db, $this->user, $this->pass, $this->db_name);
            if (!$this->conn->errno) {
                return $this->conn;
            } else {
                http_response_code(400);
                echo json_encode(array("code" => "-999", "message" => "Connection error:" . $this->conn->errno));
                exit;
            }
        } catch (Exception $exception) {
            http_response_code(400);
            echo json_encode(array("code" => "-999", "message" => "Connection error: " . $exception->getMessage()));
            exit;
        }
    }
}
