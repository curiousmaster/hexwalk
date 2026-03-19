rule fs_linux_paths : filesystem linux paths medium_confidence
{
    meta:
        category = "filesystem"
        subcategory = "linux"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $p1 = "/etc/passwd"
        $p2 = "/tmp/"


    condition:
        any of them
}
