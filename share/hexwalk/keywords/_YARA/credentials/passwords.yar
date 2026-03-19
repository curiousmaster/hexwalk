rule cred_passwords : credentials passwords secrets medium_confidence
{
    meta:
        category = "credentials"
        subcategory = "passwords"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $p1 = "password="
        $p2 = "passwd="
        $p3 = "pwd="


    condition:
        any of them
}
