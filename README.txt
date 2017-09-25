.NAME
	exchange_to_mikrotik_blacklist_parser - send to mikrotik router list of failed tryes to login to MS Exchange



.SYNOPSYS
	
	exchange_to_mikrotik_blacklist_parser.ps1

.DESCRIPTION

	Exchange_to_mikrotik_blacklist_parser uses Microsoft Exchange Shell cmdlet "Get-EventLog" and sot it by event id 1035 that matches errors with wrong login.
	After getting ingormation script get's first IP from log and send it to mikrotik black list and to list, that contains IP's. If IP already in list script 
	goes to the next loop and don't add nothing to list's.
	To connect router script use putty.exe and ssh keys.
	List with IP's is contains in mikro.txt.
	Command that will be add to mikrotik IP's is contains in comand_to_mikro.txt.
	
	

	 