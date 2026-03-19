rule firmware_uefi_firmware_volume
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects UEFI Firmware Volume (FV) header"

    strings:
        $fv = "_FVH"

    condition:
        $fv
}


rule firmware_uefi_capsule
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects UEFI capsule update structures"

    strings:
        $capsule = "CapsuleUpdate"
        $capsule_guid = { 5A 3C 1B 8D }  // common capsule GUID prefix

    condition:
        any of them
}


rule firmware_intel_flash_descriptor
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects Intel Flash Descriptor (IFD)"

    strings:
        $ifd = { 5A A5 F0 0F }

    condition:
        $ifd at 0
}

rule firmware_pe_image
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects embedded PE executables inside firmware"

    strings:
        $mz = { 4D 5A }
        $pe = { 50 45 00 00 }

    condition:
        $mz at 0 or $pe
}

rule firmware_grub_artifacts
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects GRUB bootloader artifacts"

    strings:
        $grub1 = "GRUB"
        $grub2 = "GNU GRUB"
        $grub3 = "/boot/grub"

    condition:
        any of them
}


rule firmware_linux_kernel_strings
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects Linux kernel related strings"

    strings:
        $linux1 = "Linux version"
        $linux2 = "initramfs"
        $linux3 = "root=/dev/"

    condition:
        any of them
}


rule firmware_compression_lzma
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects LZMA compressed sections"

    strings:
        $lzma = { 5D 00 00 80 00 }

    condition:
        $lzma
}


rule firmware_compression_lz4
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects LZ4 compressed data"

    strings:
        $lz4 = { 04 22 4D 18 }

    condition:
        $lz4
}


rule firmware_ascii_paths
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects embedded filesystem paths"

    strings:
        $path1 = "/bin/"
        $path2 = "/etc/"
        $path3 = "/usr/"
        $path4 = "C:\\\\"

    condition:
        any of them
}

rule firmware_network_artifacts
{
    meta:
        author      = "Stefan Benediktsson"
        source      = "https://github.com/curiousmaster/HexWalk"
        status      = "TEST"
        sharing     = "TLP:WHITE"
        category    = "Artifacts"
        description = "Detects network-related artifacts in firmware (optimized)"

    strings:
        // URLs
        $http  = "http://"
        $https = "https://"

        // Common protocol / network indicators
        $ftp   = "ftp://"
        $tftp  = "tftp://"
        $ssh   = "ssh://"

        // Domain indicators
        $dot_com = ".com"
        $dot_net = ".net"
        $dot_org = ".org"

        // DNS / networking keywords
        $dns1 = "nameserver"
        $dns2 = "domain"
        $dns3 = "gateway"

    condition:
        2 of them
}
