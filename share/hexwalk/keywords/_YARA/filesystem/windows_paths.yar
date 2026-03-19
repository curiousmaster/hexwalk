rule fs_windows_paths : filesystem windows paths medium_confidence
{
    meta:
        category = "filesystem"
        subcategory = "windows"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $w1 = "C:\\Windows\\System32"


    condition:
        any of them
}
