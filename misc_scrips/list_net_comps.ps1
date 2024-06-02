# Ping subnet
$Subnet = "192.168.1."
1..254 | ForEach-Object {
    Start-Process -WindowStyle Hidden ping.exe -ArgumentList "-n 1 -l 0 -f -i 2 -w 1 -4 $Subnet$_"
}

$Computers = (arp.exe -a | Select-String "$Subnet.*dynam") -replace ' +', ',' |
  ConvertFrom-Csv -Header Hostname, IPv4, MAC, x, Vendor |
                   Select Hostname, IPv4, MAC

ForEach ($Computer in $Computers) {
    nslookup $Computer.IPv4 | Select-String -Pattern "^Name:\s+([^\.]+).*$" |
    ForEach-Object {
        $Computer.Hostname = $_.Matches.Groups[1].Value
    }
}

# Output the results to the console
$Computers