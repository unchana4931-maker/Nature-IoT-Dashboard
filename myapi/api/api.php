<?php

header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");

if ($_SERVER["REQUEST_METHOD"] == "OPTIONS") {
    http_response_code(200);
    exit();
}

require_once "db.php";

$method = $_SERVER["REQUEST_METHOD"];

/* =========================
   SAFE RESPONSE FUNCTION
========================= */

function response($success, $data = null, $message = "") {
    echo json_encode([
        "success" => $success,
        "message" => $message,
        "data" => $data
    ]);
    exit;
}

/* =========================
   MAIN ROUTER
========================= */

switch ($method) {

    /* =========================
       GET
    ========================= */
    case "GET":

        // SENSOR LIST
        if (isset($_GET["allsensor"]) || isset($_GET["sensor"])) {

            $sql = "SELECT * FROM sensor_data ORDER BY id DESC";
            $result = $GLOBALS['conn']->query($sql);

            $data = [];

            while ($row = $result->fetch_assoc()) {
                $data[] = $row;
            }

            response(true, $data);
        }

        // DEVICE LIST
        $sql = "SELECT * FROM devices";
        $result = $conn->query($sql);

        $data = [];

        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        response(true, $data);

    break;


    /* =========================
       POST (ADD SENSOR)
    ========================= */
    case "POST":

        $input = json_decode(file_get_contents("php://input"), true);

        if (
            !isset($input["sensor_name"]) ||
            !isset($input["sensor_value"]) ||
            !isset($input["unit"])
        ) {
            response(false, null, "Missing parameters");
        }

        $name = $conn->real_escape_string($input["sensor_name"]);
        $value = floatval($input["sensor_value"]);
        $unit = $conn->real_escape_string($input["unit"]);

        $sql = "INSERT INTO sensor_data (sensor_name, sensor_value, unit)
                VALUES ('$name', '$value', '$unit')";

        if ($conn->query($sql)) {
            response(true, null, "Sensor Added");
        }

        response(false, null, $conn->error);

    break;


    /* =========================
       PUT (CONTROL DEVICE)
    ========================= */
    case "PUT":

        $input = json_decode(file_get_contents("php://input"), true);

        if (
            !isset($input["device_name"]) ||
            !isset($input["status"])
        ) {
            response(false, null, "Missing parameters");
        }

        $name = $conn->real_escape_string($input["device_name"]);
        $status = strtoupper($input["status"]);

        if ($status != "ON" && $status != "OFF") {
            response(false, null, "Invalid status");
        }

        $sql = "UPDATE devices
                SET status='$status'
                WHERE device_name='$name'";

        if ($conn->query($sql)) {
            response(true, null, "Device Updated");
        }

        response(false, null, $conn->error);

    break;


    /* =========================
       DELETE SENSOR
    ========================= */
    case "DELETE":

        $input = json_decode(file_get_contents("php://input"), true);

        if (!isset($input["id"])) {
            response(false, null, "Missing ID");
        }

        $id = intval($input["id"]);

        $sql = "DELETE FROM sensor_data WHERE id=$id";

        if ($conn->query($sql)) {
            response(true, null, "Deleted");
        }

        response(false, null, $conn->error);

    break;


    /* =========================
       DEFAULT
    ========================= */
    default:
        response(false, null, "Method Not Allowed");
}

$conn->close();

?>