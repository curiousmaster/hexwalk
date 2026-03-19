rule os_linux : os linux indicators low_confidence
{
    meta:
        category = "os"
        subcategory = "linux"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $l1 = "Linux version"
        $l2 = "GNU"


    condition:
        any of them
}
