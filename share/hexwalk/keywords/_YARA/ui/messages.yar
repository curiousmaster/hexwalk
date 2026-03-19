rule ui_messages : ui messages low_confidence
{
    meta:
        category = "ui"
        subcategory = "messages"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $m1 = "Error:"
        $m2 = "Success"


    condition:
        any of them
}
