xquery version "3.0";

declare option exist:serialize "method=html media-type=text/html";

declare function local:body($lang2, $list2){
    let $body := for $p in $list2
return <div class="col-xs-3 bg-info" border="1">
    <h3 class="bg-primary">{$p/name/text()}</h3>
    {
    for $d in $p/doc-name
    return <div><a href="base-idd.xq?doc={replace($d/text()," ", "")}&amp;lang={$lang2}"> { $d/text() }</a></div>
    }
    </div>
    return $body
};

import module namespace ubl="urn:ubl:utils" at "ubl-utils.xqm";
(: Obtener la lista de todos los docmentos UBL con su proceso :)
let $list1 := ubl:process-list()
let $lang1 := request:get-parameter('lang','EN')




return <html>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
    <title> Topicos </title>
    <body>
        <form action="base-doclist.xq" method = "GET">
            <select name="lang" class="form-control">
                <option>DE</option>
                <option>EN</option>
                <option>ES</option>
                <option>IT</option>
                <option>NL</option>
                <option>ZH-CN</option>
                <option>ZH-TW</option>
            </select>
            <input type = "submit" name ="Enviar" value ="Seleccionar" class="btn btn-success"/>
            <a href = "search.xq?lang={$lang1}" class="btn btn-primary col-md-offset-10"> Buscar </a>
        </form>
        {local:body($lang1,$list1)}
    </body></html>
