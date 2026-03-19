rule os_embedded : os embedded indicators medium_confidence
{
    meta:
        category = "os"
        subcategory = "embedded"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $e1 = "BusyBox"
        $e2 = "Buildroot"


    condition:
        any of them
}
