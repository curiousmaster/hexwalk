rule fs_sensitive : filesystem sensitive_files secrets high_confidence
{
    meta:
        category = "filesystem"
        subcategory = "sensitive"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $s1 = "shadow"
        $s2 = "id_rsa"


    condition:
        any of them
}
