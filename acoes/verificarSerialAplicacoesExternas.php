<?php

if (isset($_GET['serialappexterno']) && isset($_GET['nomeappexterno'])) {
    $serialaplicativo = $_GET['serialappexterno'];
    $nomeaplicativo = $_GET['nomeappexterno'];
    if ($serialaplicativo !== "" && $nomeaplicativo !== "") {
        require_once('../db/mysql.php');
        abrirConexao();
        $idservico = "";
        $sql1 = mysql_query("SELECT serv_id FROM servicos WHERE serv_nome='" . $nomeaplicativo . "' AND serv_ativo=1");
        if (mysql_num_rows($sql1) > 0) {
            while ($servicos = mysql_fetch_assoc($sql1)) {
                $idservico = $servicos['serv_id'];
            }
            $sql2 = mysql_query("SELECT licen_id FROM licensas WHERE licen_chave='" . $serialaplicativo . "' AND licen_servico='" . $idservico . "' AND ((licen_ativa=0 AND licen_validade < now()) OR licen_especial=1)");
            if (mysql_num_rows($sql2) > 0) {
                echo "Licença ativa";
            } else {
                echo "Licença não encontrada ou expirada";
            }
        } else {
            echo "Serviço não encontrado ou descontinuado";
        }
        fecharConexao();
    } else {
        echo "Erro na captura do serial !";
    }
}