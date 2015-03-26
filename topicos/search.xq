
declare option exist:serialize "method=html media-type=text/html";

declare function local:fix($s){
    let $sFix : = substring-after($s, "UBL-")
    return substring-before($sFix, "-2.1")
};

declare function local:body($lang2, $list2){
    let $body := for $p in $list2
        return <div><a href="base-idd.xq?doc={replace($p/text()," ", "")}&amp;lang={$lang2}"> { $p/text() }</a></div>
    return $body
};

let $lang := request:get-parameter('lang','EN')
let $busqueda := request:get-parameter('busq', 'ID')

let $nombre := concat("/db/topicos/ubl-idd/UBL-IDD-2.1-",$lang,".xml")
let $terms :=  doc( $nombre )/idd/section/entry/business-terms/text()[. = $busqueda]/../../../@xml:id
let $list := for $d in $terms
    return
        <a> {local:fix((string($d)))} </a>

let $body := local:body($lang, $list)

return  <html>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css" />
            <title> Busqueda </title>
            <body>
                <form action="search.xq?lang={$lang}" method = "GET">
                    <input type = "text" name = 'busq' class="col-md-2" id="exmTerms" placeholder="ID, Order, Invoice, etc."/>
                    <input type = "submit" name ="Enviar" class="btn btn-success"/>
                </form>
                {$body}
            </body>
        </html>