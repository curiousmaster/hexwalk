rule fw_bootloaders : firmware bootloader indicators high_confidence
{
    meta:
        category = "firmware"
        subcategory = "bootloader"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $b1 = "U-Boot"


    condition:
        any of them
}
