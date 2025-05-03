# Get the list of IP addresses from arp -a
$ipList = arp -a | ForEach-Object {
    if ($_ -match '^\s*([0-9\.]+)\s') {
        $matches[1]
    }
}

foreach ($ip in $ipList) {
    try {
        $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
        $hostname = $hostname -replace '\.local$', ''
        Write-Output "$ip`t$hostname"
    } catch {
        Write-Output "$ip`tUnresolved"
    }
}
