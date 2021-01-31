<?php
$arquivo = fopen('text.txt', 'r');
$result = array();
while (!feof($arquivo)) {
  $result = explode("|", fgets($arquivo));
}
$r = str_split(implode(':', $result), 2);
fclose($arquivo);

$obj = [
  'jog1' => $r[0],
  'jog2' => $r[1]
];

$out = json_encode($obj);

echo $out;