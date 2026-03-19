rule crypto_weak : crypto weak_crypto indicators high_confidence
{
    meta:
        category = "crypto"
        subcategory = "weak"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $md5 = "MD5"
        $sha1 = "SHA1"


    condition:
        any of them
}
