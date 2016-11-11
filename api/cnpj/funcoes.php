<?php

function pega_o_que_interessa($inicio, $fim, $total) {
    $interesse = str_replace($inicio, '', str_replace(strstr(strstr($total, $inicio), $fim), '', strstr($total, $inicio)));
    return($interesse);
}

function getHtmlCNPJ($cnpj, $captcha) {
    $pasta_cookies = 'cookies_cnpj/';
    define('COOKIELOCAL', str_replace('\\', '/', realpath('./')) . '/' . $pasta_cookies);
    define('HTTPCOOKIELOCAL', 'http://' . $_SERVER['SERVER_NAME'] . "/kafnetservicos/api/cnpj/" . $pasta_cookies);
    
    session_start();
    $cookie = "";
    $cookieFile = COOKIELOCAL . session_id();
    $cookieFile_fopen = HTTPCOOKIELOCAL . session_id();
    if (!file_exists($cookieFile)) {
        return false;
    } else {
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

            if (!strstr($conteudo, 'flag	1')) {
                $linha = chr(10) . chr(10) . 'www.receita.fazenda.gov.br	FALSE	/pessoajuridica/cnpj/cnpjreva/	FALSE	0	flag	1' . chr(10);
                $novo_cookie = str_replace(chr(10) . chr(10), $linha, $conteudo);

                unlink($cookieFile);

                $file = fopen($cookieFile, 'w');
                fwrite($file, $novo_cookie);
                fclose($file);
            }
            $cookie = $sessionName . '=' . $sessionId . ';flag=1';
        }
    }

    if (!empty($cookie)) {
        $post = array(
            'submit1' => 'Consultar',
            'origem' => 'comprovante',
            'cnpj' => $cnpj,
            'txtTexto_captcha_serpro_gov_br' => $captcha,
            'search_type' => 'cnpj'
        );

        $post = http_build_query($post, NULL, '&');

        $ch = curl_init('http://www.receita.fazenda.gov.br/pessoajuridica/cnpj/cnpjreva/valida.asp');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        curl_setopt($ch, CURLOPT_COOKIEFILE, $cookieFile);
        curl_setopt($ch, CURLOPT_COOKIEJAR, $cookieFile);
        curl_setopt($ch, CURLOPT_COOKIE, $cookie);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_MAXREDIRS, 3);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_REFERER, 'http://www.receita.fazenda.gov.br/pessoajuridica/cnpj/cnpjreva/Cnpjreva_Solicitacao2.asp');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $html = curl_exec($ch);
        curl_close($ch);
        return $html;
    } else {
        return false;
    }
}

function parseHtmlCNPJ($html) {
    $campos = array(
        'NÚMERO DE INSCRIÇÃO',
        'DATA DE ABERTURA',
        'NOME EMPRESARIAL',
        'TÍTULO DO ESTABELECIMENTO (NOME DE FANTASIA)',
        'CÓDIGO E DESCRIÇÃO DA ATIVIDADE ECONÔMICA PRINCIPAL',
        'CÓDIGO E DESCRIÇÃO DAS ATIVIDADES ECONÔMICAS SECUNDÁRIAS',
        'CÓDIGO E DESCRIÇÃO DA NATUREZA JURÍDICA',
        'LOGRADOURO',
        'NÚMERO',
        'COMPLEMENTO',
        'CEP',
        'BAIRRO/DISTRITO',
        'MUNICÍPIO',
        'UF',
        'ENDEREÇO ELETRÔNICO',
        'TELEFONE',
        'ENTE FEDERATIVO RESPONSÁVEL (EFR)',
        'SITUAÇÃO CADASTRAL',
        'DATA DA SITUAÇÃO CADASTRAL',
        'MOTIVO DE SITUAÇÃO CADASTRAL',
        'SITUAÇÃO ESPECIAL',
        'DATA DA SITUAÇÃO ESPECIAL');

    $caract_especiais = array(
        chr(9),
        chr(10),
        chr(13),
        '&nbsp;',
        '</b>',
        /* '  ', */
        '<b>MATRIZ<br>',
        '<b>FILIAL<br>'
    );

    $html = str_replace('<br><b>', '<b>', str_replace($caract_especiais, '', strip_tags($html, '<b><br>')));

    $html3 = $html;
    $resultado = array();
    for ($i = 0; $i < count($campos); $i++) {
        $html2 = strstr($html, utf8_decode($campos[$i]));
        $resultado[] = trim(pega_o_que_interessa(utf8_decode($campos[$i]) . '<b>', '<br>', $html2));
        $html = $html2;
    }

    if (strstr($resultado[5], '<b>')) {
        $cnae_secundarios = explode('<b>', $resultado[5]);
        $resultado[5] = $cnae_secundarios;
        unset($cnae_secundarios);
    }

    if (!$resultado[0]) {
        if (strstr($html3, utf8_decode('O número do CNPJ não é válido'))) {
            $resultado['status'] = 'CNPJ incorreto ou não existe';
        } else {
            $resultado['status'] = 'Imagem digitada incorretamente';
        }
    } else {
        $resultado['status'] = 'OK';
    }

    return $resultado;
}
