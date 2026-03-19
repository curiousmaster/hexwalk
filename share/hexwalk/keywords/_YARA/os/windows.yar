rule os_windows : os windows indicators low_confidence
{
    meta:
        category = "os"
        subcategory = "windows"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $w1 = "Windows NT"


    condition:
        any of them
}
