while($true)
{
	$ip = ""
	$cache = ""
	$i++
	$i
	$in_path = "C:\Users\Administrator\Documents\exchange_to_mikrotik_black_list\in.txt"
	$in2_path = "C:\Users\Administrator\Documents\exchange_to_mikrotik_black_list\in2.txt"
	$mikrotik_list = "C:\Users\Administrator\Documents\exchange_to_mikrotik_black_list\mikro.txt"
	$mikrotik_ip_add_list = "C:\Users\Administrator\Documents\exchange_to_mikrotik_black_list\comand_to_mikro.txt"
	[regex]$regex_true = "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
	[regex]$regex_our_ip = "10\.0\.[0-9]\.[0-9]{1,3}"
	Get-EventLog -Log "Application" -Source "*Exchange*" | Where-Object {$_.EventID -eq 1035} |Format-List -Property "Message" |Out-File $in_path 
	(gc $in_path) | ?{$_.trim() -ne ""} > $in2_path
	Get-Content $in2_path -totalcount 1 > $in_path
	$message = Get-Content $in_path
	$ip = $regex_true.Matches($message)|foreach-object{$_.Value}
	$ip
	if($ip -match $regex_our_ip)
		{
		Write-Host "This is our ip: $ip"
		}
	else
		{
		$ip
		$cache = findstr $ip $mikrotik_list	
		Write-Host "cache = $cache"
				if($cache -eq $null)
					{
						Write-Host "Add $ip to mikrotik list and to mikrotik black_list"
						echo $ip | Out-File $mikrotik_list -Encoding "UTF8" -Append
						echo "/ip firewall address-list add address=$ip list=ExchangeIPBlocks" | Out-File $mikrotik_ip_add_list -Encoding "UTF8"
						$cd_putty = "C:\Users\Administrator\Documents\exchange_to_mikrotik_black_list"
						.\putty.exe -load mikrotik -m $mikrotik_ip_add_list
					}
				else{
					Write-Host "IP is already added: $ip"
					continue
					}
		}
	start-sleep -seconds 500
}
