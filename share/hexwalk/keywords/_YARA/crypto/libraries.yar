rule crypto_libraries : crypto libraries indicators medium_confidence
{
    meta:
        category = "crypto"
        subcategory = "libraries"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $l1 = "OpenSSL"
        $l2 = "mbedTLS"


    condition:
        any of them
}
