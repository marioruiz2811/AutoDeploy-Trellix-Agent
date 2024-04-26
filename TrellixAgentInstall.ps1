param(
  [string]$Tenant,
  [string]$Token
)
Function Start ([string]$Tenant,[string]$Token)
{
    Try
    {
        If ( ( $Tenant -eq "" ) -Or ( $Token -eq "" ) )
        {
         Exit 1;
        }
        else
        {
            $TrellixInstaller = "$env:ProgramData\TrellixSmartInstaller.exe"
            [URI]$API_URL = "https://" + $Tenant +"/ComputerMgmt/agentPackageDownload/TrellixSmartInstall.download?token=" + $Token;
            $TrellixAgentInstalled = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Trellix Agent" };
            $McAfeeAgentInstalled = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "McAfee Agent" };
            If ( -Not ( $TrellixAgentInstalled.Name -eq "Trellix Agent" ) -And -Not ( $McAfeeAgentInstalled.Name -eq "McAfee Agent" ))
            {
                for ($i=0; $i -lt 5; $i++)
                {
                    If ( Test_Trellix_Connection $API_URL.Host -eq $True)
                    {
                        If ( Test-Path -Path $TrellixInstaller -PathType Leaf )
                        {
                            Remove-Item $TrellixInstaller -Force;
                        }
                        Start-BitsTransfer -Source $API_URL -Destination $TrellixInstaller;

                        If (Test-Path -Path $TrellixInstaller -PathType Leaf )
                        {
                            If ( Test-Path -Path $TrellixInstaller -PathType Leaf )
                            {
                                &  $TrellixInstaller -s -f;
                                Exit 0;
                            }
                        }
                        Break;
                    }
                    else
                    {
                        sleep -Seconds 10;
                    }
                }
                Exit 0;
            }
            else
            {
                If ( Test-Path -Path $TrellixInstaller -PathType Leaf )
                {
                    Remove-Item $TrellixInstaller -Force;
                    Exit 0;
                }
            }
        }
    }
    Catch
    {
     Exit 1;
    }
}
Function Test_Trellix_Connection ([string]$TrellixHost)
{
    Try
    {
        If (-Not (Test-Connection $TrellixHost -Count 2 -Delay 2 -Quiet))
        {
            Return $False;
        }
        else
        {
            Return $True;
        }
    }
    Catch
    {
        Exit 1;
    }
}
Start "$Tenant" "$Token"
