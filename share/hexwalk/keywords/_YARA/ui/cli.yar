rule ui_cli : ui cli low_confidence
{
    meta:
        category = "ui"
        subcategory = "cli"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $c1 = "--help"
        $c2 = "Usage:"


    condition:
        any of them
}
