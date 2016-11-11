<?php

function abrirConexao() {
    mysql_connect("localhost", "root", "kafnet@123");
    mysql_set_charset('utf8');
    mysql_select_db("kafnetservicos");
}

function fecharConexao(){
    mysql_close();
}