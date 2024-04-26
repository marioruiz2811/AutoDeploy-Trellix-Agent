# AutoDeploy Trellix Agent
Installing Trellix Agent from Active Directory. This procedure is necessary when using Trellix ePO SaaS, where there is no way to provision the Trellix Agent to new PCs newly added to the domain.

Get download link: The first part will consist of setting up a TrellxSmartAgent download link in ePO SaaS:

1. Create a group in ePO where the machines that will be automatically deployed with the Trellix Agent will be located.
2. Click on the Deployment tab.
3. Select the products that will be installed after the agent is deployed.
4. Copy the agent download URL.

Ej:
![IMG1](https://github.com/marioruiz2811/Trellix-Smart-Agent/assets/71531721/4c1dff38-cda8-421d-969a-aff21e37c244)

  From the downloaded URL we save the Tenant and Token for the Trellix Agent download:
  
  Ej:
  
  URL: https://ui-usw001.manage.trellix.com:443/ComputerMgmt/agentPackage.get?token=a0e090489225e81cc6da39394cc58ebb22381394
  
  Tenant: ui-usw001.manage.trellix.com
  
  Token: a0e090489225e81cc6da39394cc58ebb22381394
  
5. Download the powershell script from the following command: Invoke-WebRequest 'https://raw.githubusercontent.com/marioruiz2811/AutoDeploy-Trellix-Agent/main/TrellixAgentInstall.ps1' -OutFile ./TrellixAgentInstall.ps1

   Ej:
![IMG2](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/a7567694-ccff-4eaa-9126-c341980b48c7)

6. Enter the Domain Controller, create a policy for agent deployment and go to "Computer Configuration>Policies>Windows Settings>Scripts (Startup/Shutdown)/Startup" here in the "PowerShell Scripts" tab open the Startup Script location.

   Ej:
![image](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/78116c8a-3fda-41eb-b337-a1590c4692fe)

  When the Startup Scripts window opens, paste the script downloaded in step 5.
  
  Ej:
![image](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/6c1de34d-c7c6-4e23-af3c-283d7e7c53dc)

7. Open again the PowerShell Scripts properties and add the script copied above, add the Tenant and Token values obtained in step 4 as arguments.

   Ej: "-Tenant ui-usw001.manage.trellix.com -Token a0e090489225e81cc6da39394cc58ebb22381394"
![image](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/8e5c099a-c2db-415a-a27c-d2c83484dd63)

8. On the Client PC that has the GPO applied we verify that the policy is assigned, it will appear as if it has never been executed.
    
    Force Update GPO Policies: gpupdate /force
    Show GPO Result applied in PC Client: gpresult /z /scope computer | Select-String "Startup Script" -Context 0,6
   ![image](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/3f607b8a-db34-4fa3-aef8-6d502f8f7d28)

   Verify that the Agent is not installed. The McAfee directory does not exist either.

   Command: Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq "Trellix Agent" }
  ![image](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/cc30e73a-caa9-4389-8d90-681db7dfa64f)

10. Apagar la PC Cliente y luego encenderla, cuando windows inicie el script descargara el Agente de Trellix y procedera a instalarlo, esto puede tardar hasta 5 minutos, depende de la conexion a internet de la PC Client.

    
