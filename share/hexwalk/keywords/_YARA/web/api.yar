rule web_api : web api indicators medium_confidence
{
    meta:
        category = "web"
        subcategory = "api"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $a1 = "/api/"
        $a2 = "Authorization:"


    condition:
        any of them
}
