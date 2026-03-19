rule dbg_errors : debug errors medium_confidence
{
    meta:
        category = "debug"
        subcategory = "errors"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $e1 = "Exception"
        $e2 = "Segmentation fault"


    condition:
        any of them
}
