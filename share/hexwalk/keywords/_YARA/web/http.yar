rule web_http : web http indicators low_confidence
{
    meta:
        category = "web"
        subcategory = "http"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $h1 = "HTTP/1.1"
        $h2 = "Content-Type"


    condition:
        any of them
}
