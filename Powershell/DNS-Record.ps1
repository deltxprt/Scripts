function add-DnsRecord {
    param (
        [Parameter(Mandatory)]
        [string]$fqdn,
        [Parameter(Mandatory)]
        [string]$ip
    )
    $ipname = $ip.split(".")[-1]
    $DNSRecord = Get-DnsServerResourceRecord -ZoneName markaplay.local -Name $fqdn -RRType A -ErrorAction 'silentlycontinue'
    $DNSRecordReverse = Get-DnsServerResourceRecord -ZoneName 0.0.10.in-addr.arpa -Name $ipname -RRType CName -ErrorAction 'silentlycontinue'
    if ($DNSRecord -or $DNSRecordReverse) {
        "Record already exist"
    }
    else {
        Add-DnsServerResourceRecordA -Name $fqdn -ZoneName markaplay.local -IPv4Address $ip
        Add-DnsServerResourceRecordCName -Name $ipname -ZoneName 0.0.10.in-addr.arpa -HostNameAlias "$fqdn.markaplay.local"
        Get-DnsServerResourceRecord -ZoneName markaplay.local -Name $fqdn -RRType A -ErrorAction 'silentlycontinue'
        Get-DnsServerResourceRecord -ZoneName 0.0.10.in-addr.arpa -Name $ipname -RRType CName -ErrorAction 'silentlycontinue'
    }
}
function remove-DnsRecord {
    param (
        [Parameter(Mandatory)]
        [string]$fqdn,
        [Parameter(Mandatory)]
        [string]$ip
    )
    $ipname = $ip.split(".")[-1]
    $DNSRecord = Get-DnsServerResourceRecord -ZoneName markaplay.local -Name $fqdn -RRType A -ErrorAction 'silentlycontinue'
    $DNSRecordReverse = Get-DnsServerResourceRecord -ZoneName 0.0.10.in-addr.arpa -Name $ipname -RRType CName -ErrorAction 'silentlycontinue'
    if ($DNSRecord -or $DNSRecordReverse) {
        Remove-DnsServerResourceRecord -Name $fqdn -RRType "A" -RecordData $ip -ZoneName markaplay.local -Force
        Remove-DnsServerResourceRecord -Name $ipname -RRType CName -RecordData "$fqdn.markaplay.local" -ZoneName 0.0.10.in-addr.arpa -Force
    }
    else {
        "Record doesn't exist"
    }
}
