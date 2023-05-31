$ErrorActionPreference= 'silentlycontinue'

# Error log tracking to see where script hangs up
$Logfile = "C:\Windows\BCD\Fix\Logs\Fix-$env:computername.log"
Function LogWrite
{
   Param ([string]$logstring)
   Add-content $Logfile -value $logstring
}
Function ICheck1
{
    #Get content of XML file for I
    [xml]$IConfig = Get-Content -Path "$DefI\Config.xml" 

    #Pull values to check from XML for I
    $IFixCheck = $IConfig.TestDefinition.Param.Value

    #Values to check
    $valuesToCheck = @("123456789", "034567891", "254738902", "543789120", "457893401", "543789012", "548390234")

    $flag = $false
    foreach ($value in $valuesToCheck) {
        if ($IFixCheck -notcontains $value)     {
            LogWrite "First I Check - Values not equal, Installing  Fix - Config.xml"
            Copy-Item "C:\Windows\BCD\Fix\Config.xml" -Destination "$DefI"
            $flag = $true
            break
        }
    }

    if($flag -eq $false){
        LogWrite "**** First I Check - I File Matched, nothing further needed ****"
    }
}


Function ACheck1
    {
        #Set Path for A
        $APath = "C:\Web32Page\"
        
        #Get content of XML files for A
        [xml]$AConfig = Get-Content -Path "$APath\NCVSConfig.xml"
        [xml]$AMultiCheck = Get-Content -Path "$APath\NCVMultiCheck.xml"
        
        #Pull values to check from XML for A
        $AFixCheck = $AConfig.TestDefinition.Param.Value
        $AFixMultiCheck = $AMultiCheck.TestDefinition.Param.Value
        
        #Values to check
        $AvaluesToCheck = @("8","7","99999-999","000090032","000025002","5","091900553","092356187")    
        
        $FMon1 = 0
        foreach ($value in $AvaluesToCheck) {
        if ($AFixCheck -notcontains $value) {
        $FMon1 = 1
        break
        }
        }
        
        $AMultivaluesCheck = @("000008002")
        
        $FMon2 = 0
        foreach ($value in $AMultivaluesCheck) {
        if ($AFixMultiCheck -notcontains $value) {
        $FMon2 = 1
        break
        }
        }
        
        #Check for DC7.dat file
        $DC7 = "$APath\DC7.dat"
        if (Test-Path $DC7) {
            $DC7Check = Get-Content -Path $DC7
            if ($DC7Check -notcontains "CODELINE.MULTICHECKTESTDEFINITIONFILE=c:\Web32Page\NCVMultiCheck.xml" -and $DC7Check -notcontains "GLOBAL.MACHINEID=") {
                $FMon3 = 1
            }
        } else {
            $FMon3 = 0
        }
        
        #Final output to determine if Fix exist or not
        if ($FMon1 -eq 1 -or $FMon2 -eq 1 -or $FMon3 -eq 1)     {
            LogWrite "First A Check - Values not equal, Installing Fix - NCVSConfig.xml"
            Copy-Item "C:\Windows\BCD\Fix\A\NCVSConfig.xml" -Destination "C:\WebA\"
            LogWrite "First A Check - Values not equal, Installing Fix - DC7.DAT"
            Copy-Item "C:\Windows\BCD\Fix\A\DC7.DAT" -Destination "C:\WebA\"
            LogWrite "First A Check - Values not equal, Installing Fix - NCVMultiCheck.xml"
            Copy-Item "C:\Windows\BCD\Fix\A\NCVMultiCheck.xml" -Destination "C:\WebA\"
        }
        else {
            LogWrite "**** First Check - A Values Match, nothing further needed ****"
        }
}
Function ACheck2
{
    #Set Path for A
    $APath = "C:\WebA\"
    
    #Get content of XML files for A
    [xml]$AConfig = Get-Content -Path "$APath\NCVSConfig.xml"
    [xml]$AMultiCheck = Get-Content -Path "$APath\NCVMultiCheck.xml"
    
    #Pull values to check from XML for A
    $AFixCheck = $AConfig.TestDefinition.Param.Value
    $AFixMultiCheck = $AMultiCheck.TestDefinition.Param.Value
    
    #Values to check
    $AvaluesToCheck = @("8","7","99999-999","000090032","000025002","5","091900553","092356187")

    $FMon1 = 0
    foreach ($value in $AvaluesToCheck) {
    if ($AFixCheck -notcontains $value) {
    $FMon1 = 1
    break
    }
    }
    
    $AMultivaluesCheck = @("000008002")
    
    $FMon2 = 0
    foreach ($value in $AMultivaluesCheck) {
    if ($AFixMultiCheck -notcontains $value) {
    $FMon2 = 1
    break
    }
    }
    
    #Check for DC7.dat file
    $DC7 = "$APath\DC7.dat"
    if (Test-Path $DC7) {
        $DC7Check = Get-Content -Path $DC7
        if ($DC7Check -notcontains "CODELINE.MULTICHECKTESTDEFINITIONFILE=c:\Web32Page\NCVMultiCheck.xml" -and $DC7Check -notcontains "GLOBAL.MACHINEID=") {
            $FMon3 = 1
        }
    } else {
        $FMon3 = 0
    }
    
    #Final output to determine if Fix exist or not
    if ($FMon1 -eq 1 -or $FMon2 -eq 1 -or $FMon3 -eq 1)     {
        LogWrite "Second A Check - Values not equal, Installing Fix - NCVSConfig.xml"
        Copy-Item "C:\Windows\BCD\Fix\A\NCVSConfig.xml" -Destination "C:\WebA\"
        LogWrite "Second A Check - Values not equal, Installing Fix - DC7.DAT"
        Copy-Item "C:\Windows\BCD\Fix\A\DC7.DAT" -Destination "C:\WebA\"
        LogWrite "Second A Check - Values not equal, Installing Fix - NCVMultiCheck.xml"
        Copy-Item "C:\Windows\BCD\Fix\A\NCVMultiCheck.xml" -Destination "C:\WebA\"
    }
    else {
        LogWrite "**** Second Check - A Values Match, nothing further needed ****"
    }
}
Function ICheck2
{
#Get content of XML file for I
[xml]$IConfig = Get-Content -Path "$DefI\Config.xml" 

#Pull values to check from XML for I
$IFixCheck = $IConfig.TestDefinition.Param.Value

#Values to check
$valuesToCheck = @("123456789", "034567891", "254738902", "543789120", "457893401", "543789012", "548390234")

$flag = $false
foreach ($value in $valuesToCheck) {
    if ($IFixCheck -notcontains $value)     {
        LogWrite "Second I Check - Values not equal, Installing  Fix - Config.xml"
        Copy-Item "C:\Windows\BCD\Fix\Config.xml" -Destination "$DefI"
        $flag = $true
        break
    }
}

if($flag -eq $false){
    LogWrite "**** Second I Check - I File Matched, nothing further needed ****"
}

}
#Add Computer Name and Date/Time to top of log entry
LogWrite $env:computername
LogWrite (get-date)
LogWrite ---------------------------------------------------------
# Find File Paths for A/I
$ITarget = Get-ChildItem "C:\Program Files*\jDummy\I*\Config\"
$DefI = Resolve-Path $ITarget | Select-Object -Last 1
If (Test-Path -Path "C:\WebA\")
{
    ACheck1
    ACheck2
}
elseif (Test-Path -Path $ITarget)
{
    ICheck1
    ICheck2
}
else
{
    LogWrite '**** No File Found ****'
    Remove-item "C:\Windows\BCD\Fix\" -Recurse
    exit 1
}
Remove-item "C:\Windows\BCD\Fix\" -Recurse