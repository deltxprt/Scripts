$csv1 = import-csv -path $cv1
$csv2 = import-csv -path $cv2

foreach ($c1 in $csv1) {
    $matched = $false
    foreach ($c2 in $csv2) {
        $obj = "" | select 'Name','IP','GUID'
        if ($n.name -eq $sid.name ) {
            $matchCounter++
            $matched = $true
            $obj.Name = $c1.Name
            $obj.GUID = $c2.GUID
            $obj.IP = $c1.IP

            write-host "Match Found! " "$matchCounter"
            $obj | Export-Csv -path .\result.csv -append -NoTypeInformation
        }
    }
}
