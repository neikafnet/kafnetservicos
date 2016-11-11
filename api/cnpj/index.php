<html>
    <head>
        <title>CNPJ e Captcha</title>
    </head>
    <body>
        <form method="get" action="http://104.198.75.156/api/cnpj/capturadados">
            <p><span class="titleCats">CNPJ e Captcha</span>
                <br />
                <input type="text" name="CnpJ" maxlength="19" value="21937916000142" required /> 
                <b style="color: red">CNPJ</b>
                <br />
                <img src="http://104.198.75.156/api/cnpj/captchareceita" border="0">
                <br />
                <input type="text" name="CaPtcHA" maxlength="6" required />
                <b style="color: red">O que vê na imagem acima?</b>
                <br />
            </p>
            <p>
                <input id="id_submit" name="enviar" type="submit" value="Consultar"/>
            </p>
        </form>
    </body>
</html>