rule net_domains : network domains indicators low_confidence
{
    meta:
        category = "network"
        subcategory = "domains"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $d1 = /\b[a-zA-Z0-9.-]+\.(com|net|org|io|se)\b/


    condition:
        any of them
}
