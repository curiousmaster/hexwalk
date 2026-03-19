rule fw_hardware : firmware hardware indicators medium_confidence
{
    meta:
        category = "firmware"
        subcategory = "hardware"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $h1 = "GPIO"
        $h2 = "UART"


    condition:
        any of them
}
