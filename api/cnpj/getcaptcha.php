<?php

$pasta_cookies = 'cookies_cnpj/';
define('COOKIELOCAL', str_replace('\\', '/', realpath('./')) . '/' . $pasta_cookies);
define('HTTPCOOKIELOCAL', 'http://' . $_SERVER['SERVER_NAME'] . "/kafnetservicos/api/cnpj/" . $pasta_cookies);

session_start();
$cookieFile = COOKIELOCAL . session_id();
$cookieFile_fopen = HTTPCOOKIELOCAL . session_id();

if (!file_exists($cookieFile)) {
    $file = fopen($cookieFile, 'w');
    fclose($file);
}

$url = 'http://www.receita.fazenda.gov.br/pessoajuridica/cnpj/cnpjreva/captcha/gerarCaptcha.asp';
$ch1 = curl_init($url);
curl_setopt($ch1, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36');
curl_setopt($ch1, CURLOPT_COOKIEJAR, $cookieFile);
curl_setopt($ch1, CURLOPT_COOKIEFILE, $cookieFile);
curl_setopt($ch1, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($ch1, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($ch1, CURLOPT_CONNECTTIMEOUT, 10);
curl_setopt($ch1, CURLOPT_TIMEOUT, 10);
$imgsource = curl_exec($ch1);
curl_close($ch1);

$conteudo = "";
$file = fopen($cookieFile_fopen, 'r');
while (!feof($file)) {
    $conteudo .= fread($file, 1024);
}
fclose($file);

if (!empty($conteudo)) {
    $explodir = explode(chr(9), $conteudo);

    $sessionName = trim($explodir[count($explodir) - 2]);
    $sessionId = trim($explodir[count($explodir) - 1]);


    $cookie = $sessionName . '=' . $sessionId;

    $ch = curl_init('http://www.receita.fazenda.gov.br/pessoajuridica/cnpj/cnpjreva/Cnpjreva_Solicitacao2.asp');
    curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36');
    curl_setopt($ch, CURLOPT_COOKIEFILE, $cookieFile);
    curl_setopt($ch, CURLOPT_COOKIEJAR, $cookieFile);
    curl_setopt($ch, CURLOPT_COOKIE, $cookie);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 3);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $html = curl_exec($ch);
    curl_close($ch);

    if (strlen($imgsource) !== "1" || empty($html)) {
        $info = imagecreate(230, 50);
        $corCaptcha = imagecolorallocate($info, 255, 255, 255);
        $corTexto = imagecolorallocate($info, 0, 0, 0);
        imagestring($info, 5, 20, 15, "Sistema indisponivel", $corTexto);
        imagepng($info);
        imagedestroy($info);
    } else {
        $imagemCaptcha = imagecreatefromstring($imgsource);
        imagepng($imagemCaptcha);
        imagedestroy($imagemCaptcha);
    }
} else {
    $info = imagecreate(230, 50);
    $corCaptcha = imagecolorallocate($info, 255, 255, 255);
    $corTexto = imagecolorallocate($info, 0, 0, 0);
    imagestring($info, 5, 20, 15, "Sistema indisponivel", $corTexto);
    imagepng($info);
    imagedestroy($info);
}
?>