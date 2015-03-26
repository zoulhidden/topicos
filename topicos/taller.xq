xquery version "3.0";

declare option exist:serialize "method=html media-type=text/html";

declare function local:documentoIdioma($nombre, $doc){
    let $docs :=  doc($nombre)/idd/section[ @xml:id = $doc]/entry
return $docs
};

declare function local:tablas($doc){
    let $filas := for $x in $doc
        return <tr>
        <td>{$x/dictionary-entry-name/text()}</td><td>{$x/business-terms/text()}</td><td>{$x/definition/text()}</td></tr>
        
    let $tabla := <table><tr><tH>UBL NAME </tH><tH>TERM </tH><TH>DEFINITION</TH></tr>{$filas}</table>
return $tabla
};

let $doc := request:get-parameter ('doc','UBL-Order-2.1')
let $lang := request:get-parameter ('lang','EN')

let $nombre := concat("/db/topicos/ubl-idd/UBL-IDD-2.1-",$lang,".xml")

let $documento := local:documentoIdioma($nombre,$doc)
let $tabla :=  local:tablas($documento)


return 
<html> 
    <style>
       table, th, td {{ border: 1px solid black;}}
    </style>
    <head>
        <title>DOCUMENTOS</title>
    </head>
    <body>
        <form align="center" action="" method="GET">
        Idioma      <select name="lang" id="lang">
                        <option value="DE">DE</option>
                        <option value="EN">EN</option>
                        <option value="ES">ES</option>
                        <option value="IT">IT</option>
                        <option value="NL">NL</option>
                        <option value="ZH-CN">ZH-CN</option>
                        <option value="ZH-TW">ZH-TW</option>
                    </select>
        Documento   <input name="doc" type="text"/><br/><br/>
                    <input value="BUSCAR" type="submit"/>
        </form>
        <br/>
        <center>
        <br/>
        {$tabla}
        </center>
    </body>
</html>