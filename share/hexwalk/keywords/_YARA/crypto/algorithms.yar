rule crypto_algorithms : crypto algorithms indicators low_confidence
{
    meta:
        category = "crypto"
        subcategory = "algorithms"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $aes = "AES"
        $rsa = "RSA"
        $des = "DES"


    condition:
        any of them
}
