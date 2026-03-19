rule dbg_logging : debug logging low_confidence
{
    meta:
        category = "debug"
        subcategory = "logging"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $l1 = "log_level"
        $l2 = "logger"


    condition:
        any of them
}
