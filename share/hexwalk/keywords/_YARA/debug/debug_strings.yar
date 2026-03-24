rule dbg_strings : debug strings_indicator low_confidence
{
    meta:
        category = "debug"
        subcategory = "strings"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $d1 = "DEBUG"
        $d2 = "TRACE"


    condition:
        any of them
}
