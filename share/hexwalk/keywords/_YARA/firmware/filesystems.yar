rule fw_filesystems : firmware filesystem indicators high_confidence
{
    meta:
        category = "firmware"
        subcategory = "filesystem"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $f1 = "Squashfs"
        $f2 = "UBI#"


    condition:
        any of them
}
