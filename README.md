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
  
6. Download the powershell script from the following command: Invoke-WebRequest 'https://raw.githubusercontent.com/marioruiz2811/AutoDeploy-Trellix-Agent/main/TrellixAgentInstall.ps1' -OutFile ./TrellixAgentInstall.ps1
   Ej:
![IMG2](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/a7567694-ccff-4eaa-9126-c341980b48c7)

Ingresamos al Domain Controller, creamos una politica para despliegue de agente e ingresamos a "Computer Configuration>Policies>Windows Settings>Scripts (Startup/Shutdown)/Startup" aqui en la pestaña de "PowerShell Scripts" abrimos la ubicacion los script de Startup.
![image](https://github.com/marioruiz2811/AutoDeploy-Trellix-Agent/assets/71531721/78116c8a-3fda-41eb-b337-a1590c4692fe)

