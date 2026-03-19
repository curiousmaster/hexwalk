rule net_urls : network urls indicators medium_confidence
{
    meta:
        category = "network"
        subcategory = "urls"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $u1 = "http://"
        $u2 = "https://"


    condition:
        any of them
}
