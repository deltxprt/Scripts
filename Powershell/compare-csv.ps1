$csv1 = import-csv -path D:\Windows\Documents\PowerShell\Testing\Server_Net.csv
$csv2 = import-csv -path D:\Windows\Documents\PowerShell\Testing\Server_ID.csv

foreach ($c1 in $csv1) {
    #$matched = $false
    foreach ($c2 in $csv2) {
        for($i=0;$i -le $c1.name.count; $i++){
            $name = $c1.Name
            $obj = "" | Select-Object 'Name','IP','GUID'
            if ($c1.name -eq $c2.name ) {
                #$matchCounter++
                #$matched = $true
                $obj.Name = $c1.Name
                $obj.GUID = $c2.GUID
                $obj.IP = $c1.IP

                #write-host "Match Found! " "$matchCounter"
                $obj | Export-Csv -path .\result.csv -append -NoTypeInformation
            }
            Write-Progress -Activity "Finding matches Progress" -Status "current Server : $name" -PercentComplete $i
            if ($i -eq 100) {
                Write-host "Done!"
            }
        }
    }
}
