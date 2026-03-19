rule cred_private_keys : credentials private_keys secrets high_confidence
{
    meta:
        category = "credentials"
        subcategory = "private_keys"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $k1 = "BEGIN PRIVATE KEY"
        $k2 = "BEGIN RSA PRIVATE KEY"


    condition:
        any of them
}
