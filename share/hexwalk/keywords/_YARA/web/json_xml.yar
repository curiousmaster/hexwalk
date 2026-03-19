rule web_data : web data indicators low_confidence
{
    meta:
        category = "web"
        subcategory = "data"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $j1 = "{"
        $x1 = "<?xml"


    condition:
        any of them
}
