<?php
$host = 'RDS_ENDPOINT_HERE';
$user = 'admin';
$pass = 'CHANGE_ME';
$db   = 'testdb';

header('Content-Type: text/plain');
mysqli_report(MYSQLI_REPORT_OFF);
$conn = @new mysqli($host, $user, $pass, $db, 3306, null);

if ($conn->connect_errno) {
  http_response_code(500);
  echo "DB CONNECT ERROR: ({$conn->connect_errno}) {$conn->connect_error}\n";
  exit;
}

$res = $conn->query("SELECT id, name, email FROM users ORDER BY id");
echo "users:\n";
while ($row = $res->fetch_assoc()) {
  echo "{$row['id']} | {$row['name']} | {$row['email']}\n";
}
$conn->close();
