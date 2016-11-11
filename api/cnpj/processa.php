<?php

if (isset($_GET['CnpJ']) && isset($_GET['CaPtcHA'])) {
    require('funcoes.php');
    $cnpj = $_GET['CnpJ'];
    $captcha = $_GET['CaPtcHA'];
    if (strlen($cnpj) >= 14 && strlen($captcha) >= 2) {
        $getHtmlCNPJ = getHtmlCNPJ($cnpj, $captcha);
        if ($getHtmlCNPJ) {
            $campos = parseHtmlCNPJ($getHtmlCNPJ);
            print_r($campos);
        } else {
            echo "['status'] Captcha expirou, tente com um novo Captcha!";
        }
    } else {
        echo "['status'] Campos invalídos ";
    }
} else {
    echo "['status'] Campos invalídos ";
}
?>