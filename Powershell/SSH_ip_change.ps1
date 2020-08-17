$file = get-content 'C:\Users\BVinc\.ssh\known_hosts'
$find = read-host - prompt 'ip of the ssh connection to delete'
foreach ($line in $file) {
    if ($line -match $find) {
        $line.replace($find, "") | Set-content $file
    }
}