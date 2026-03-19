rule cred_api_keys : credentials api_keys secrets high_confidence
{
    meta:
        category = "credentials"
        subcategory = "api_keys"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $aws = /AKIA[0-9A-Z]{16}/
        $google = /AIza[0-9A-Za-z\-_]{35}/


    condition:
        any of them
}
