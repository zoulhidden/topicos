declare option exist:serialize "method=html media-type=text/html";

declare function local:concatDoc($language, $docum){
    let $nombre := concat("/db/topicos/ubl-idd/UBL-IDD-2.1-",$language,".xml")
return doc( $nombre )/idd/section[@xml:id = concat("UBL-",$docum,"-2.1")]/entry
};

declare function local:rows($document){
    let $filas := for $d in $document
    return 
        <tr>
            <td class="info">{$d/ubl-name/text()}</td>
            <td class="info">{$d/business-terms/text()}</td>
            <td class="info">{$d/definition/text()}</td>
        </tr>
return $filas
};

declare function local:listLang($language){
    let $document := concat ("/db/topicos/ubl-idd/UBL-IDD-2.1-", $language,".xml")
    let $elementos := doc($document)/idd
    let $lista := $elementos/section/@xml:id
    let $list := for $d in $lista
    return
        <option> { local:fix((string($d)))} </option>
return $list
};

declare function local:fix($s){
    let $sFix : = substring-after($s, "UBL-")
    return substring-before($sFix, "-2.1")
};

declare function local:table($rows){
    let $tabla := <table class= "table table-hover">
    <tr class="success">
        <td><b>UBL Name</b></td>
        <td><b>Terms</b></td>
        <td><b>Definition</b></td>
    </tr>
    { $rows }</table>
return $tabla
};

declare function local:htmlInd($table, $list, $doc, $lang){
    <html>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
    <head>
        <title>UBL - IDD</title>
    </head>
    <body>
    <form action="base-idd.xq" method = "GET">
    <div>
        <h3>Seleccione el documento:</h3>
    </div>
    <div>
        <input type = "hidden" name="lang" value = "{$lang}" />
        <select name="doc" class="form-control">
            { $list }
        </select>
    </div>
        <input type = "submit" name ="Enviar" class="btn btn-success"/>
    </form>
    <h2> {$doc} </h2>
    { $table }
    </body>
</html>
};

let $doc := request:get-parameter('doc','Order')
let $lang := request:get-parameter('lang','EN')

let $document := local:concatDoc($lang, $doc)

let $filas := local:rows($document)
    
let $tabla := local:table($filas)

let $lista := local:listLang($lang)

let $htmlIndex := local:htmlInd($tabla, $lista, $doc, $lang)

return $htmlIndex
