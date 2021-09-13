function Test-MyPassword {
    <#
    .SYNOPSIS
    Tests if the password is valid against the domain.

    .DESCRIPTION
    Tests if the password is valid against the domain.

    .PARAMETER UserName
    Provide username to test password for. If not provided user will be prompted to provide one

    .PARAMETER Password
    Provide password for the user. If not provided user will be prompted to provide one

    .PARAMETER Domain
    Provide Domain name. If user doesn't provide Domain name, the command will try to find it automatically (if computer is part of the domain)

    .PARAMETER ReturnObject
    Request return of an object for additional testing

    .EXAMPLE
    Test-MyPassword

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    param(
        [string] $UserName,
        [securestring] $Password,
        [string] $Domain,
        [switch] $ReturnObject
    )
    Begin {
        if (-not $Domain) {
            $Domain = $env:USERDOMAIN
        }
        if (-not $UserName) {
            Write-Color -Text "Please provide ", "UserName", " you want to test: " -Color Gray, Yellow, Gray -NoNewLine
            $UserName = Read-Host
        }
        if (-not $Password) {
            Write-Color -Text "Please provide ", "Password", " for the account: " -Color Gray, Yellow, Gray -NoNewLine
            $Password = Read-Host -AsSecureString
        }
        $PasswordPlain = [System.Net.NetworkCredential]::new([string]::Empty, $Password).Password
    }
    Process {
        Add-Type -AssemblyName System.DirectoryServices.AccountManagement
        $Context = [System.DirectoryServices.AccountManagement.ContextType]::Domain
        $PrincipalContext = [System.DirectoryServices.AccountManagement.PrincipalContext]::new($Context, $Domain)
        $ProperPassword = $PrincipalContext.ValidateCredentials($UserName, $PasswordPlain)
        if ($ProperPassword) {
            Write-Color -Text "Password is valid for the account: ", $UserName, " in the domain: ", $Domain, "." -Color Gray, Green, Gray, Green, Gray
        } else {
            Write-Color -Text "Password is not valid for the account: ", $UserName, " in the domain: ", $Domain, "." -Color Gray, Red, Gray, Red, Gray
        }
        if ($ReturnObject) {
            [PSCustomobject] @{
                UserName        = $UserName
                Domain          = $Domain
                IsPasswordValid = $ProperPassword
            }
        }
    }
    End {
        $Password = $null
        $PasswordPlain = $null
        [System.GC]::Collect()
    }
}