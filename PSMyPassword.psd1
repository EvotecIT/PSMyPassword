@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2021 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Module helping out with changing, resetting, testing and protecting password.'
    FunctionsToExport    = @('Protect-MyPassword', 'Set-MyPassword', 'Test-MyPassword')
    GUID                 = 'dd774c97-163b-4a23-b712-3b0cd0063bbc'
    ModuleVersion        = '0.0.4'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Password', 'Secret', 'Security')
            ProjectUri                 = 'https://github.com/EvotecIT/PSMyPassword'
            IconUri                    = 'https://evotec.xyz/wp-content/uploads/2019/01/PSMyPassword.png'
            ExternalModuleDependencies = @('Microsoft.PowerShell.Utility', 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Security')
        }
    }
    RequiredModules      = @(@{
            ModuleVersion = '0.87.3'
            ModuleName    = 'PSWriteColor'
            Guid          = '0b0ba5c5-ec85-4c2b-a718-874e55a8bc3f'
        }, 'Microsoft.PowerShell.Utility', 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Security')
    RootModule           = 'PSMyPassword.psm1'
}