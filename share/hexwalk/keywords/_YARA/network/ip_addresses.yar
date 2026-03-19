rule net_ips : network ip indicators low_confidence
{
    meta:
        category = "network"
        subcategory = "ip"
        author = "HexWalk Starter Pack"
        description = "Auto-generated starter rule"

    strings:

        $ipv4 = /([0-9]{1,3}\.){3}[0-9]{1,3}/


    condition:
        any of them
}
