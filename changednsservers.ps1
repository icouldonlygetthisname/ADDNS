$computers = get-content "D:\folder\serverlistA.txt"
$DNSServers = ("1.1.1.1","2.2.2.2") 
$DNSServers2 = ("1.1.1.3","2.2.2.3")  
$cred = Get-Credential -UserName domain\username -Message "password"

foreach ($computer in $computers) { 
        { 
   $NICs = Get-WMIObject Win32_NetworkAdapterConfiguration -computername $computer -Credential $cred |where{$_.IPEnabled -like "10.1."}
   foreach ($NIC in $NICs) {$NIC.SetDNSServerSearchOrder($DNSServers); $NIC.SetDynamicDNSRegistration($TRUE)}
         }
$NIC2s = Get-WMIObject Win32_NetworkAdapterConfiguration -computername $computer -Credential $cred |where{$_.IPEnabled -like "10.2."}
Foreach($NIC2 in $NIC2s) {$NIC2.SetDNSServerSearchOrder($DNSServers2); $NIC2.SetDynamicDNSRegistration($TRUE)}
 

}
