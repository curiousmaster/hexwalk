rule ui_localization : ui localization low_confidence
{
    meta:
        category = "ui"
        subcategory = "localization"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $l1 = "en_US"
        $l2 = "sv_SE"


    condition:
        any of them
}
