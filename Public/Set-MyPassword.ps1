function Set-MyPassword {
    <#
    .SYNOPSIS
    Allows the user to change the password of the Active Directory account using PowerShell, including when the password is expired.

    .DESCRIPTION
    Allows the user to change the password of the Active Directory account using PowerShell, including when the password is expired. This command can be run on a computer outside of the domain and doesn't require any special permissions.

    .PARAMETER UserName
    Provide username to change password for. If not provided user will be prompted to provide one

    .PARAMETER OldPassword
    Provide old password for the user. If not provided user will be prompted to provide one

    .PARAMETER NewPassword
    Provide new password for the user. If not provided user will be prompted to provide one

    .PARAMETER DomainController
    Provide DomainController name or ip address. If user doesn't provide Domain Controller name, the command will try to find it automatically (if computer is part of the domain)

    .PARAMETER Domain
    Provide Domain name. If user doesn't provide Domain name, the command will try to find it automatically (if computer is part of the domain)

    .EXAMPLE
    Set-MyPassword

    .EXAMPLE
    Set-MyPassword -UserName "svc_test" -DomainController "ad1.ad.evotec.xyz"

    .NOTES
    General notes
    #>
    [CmdletBinding(DefaultParameterSetName = 'Secure')]
    param(
        [Parameter(ParameterSetName = 'Secure')][string] $UserName,
        [Parameter(ParameterSetName = 'Secure')][securestring] $OldPassword,
        [Parameter(ParameterSetName = 'Secure')][securestring] $NewPassword,
        [Parameter(ParameterSetName = 'Secure')][alias('DC', 'Server', 'ComputerName')][string] $DomainController,
        [Parameter(ParameterSetName = 'Secure')][string] $Domain,
        [switch] $NoConfirm
    )
    Begin {
        $Failed = $false
        Write-Color
        if (-not $DomainController) {
            if ($env:COMPUTERNAME -eq $env:USERDOMAIN) {
                # not joined to domain, lets prompt for DC
                Write-Color -Text "No Active Directory detected. ", "Please provide Domain Controller ", "DNS name or IP Address", ' to continue: ' -NoNewLine -Color Gray, Yellow, Gray, Yellow
                $DomainController = Read-Host
            } else {
                if (-not $Domain) {
                    $Domain = $Env:USERDNSDOMAIN
                }
                try {
                    $Context = [System.DirectoryServices.ActiveDirectory.DirectoryContext]::new([System.DirectoryServices.ActiveDirectory.DirectoryContextType]::Domain, $Domain)
                    $DomainController = ([System.DirectoryServices.ActiveDirectory.DomainController]::FindOne($Context)).Name
                    Write-Color -Text "Detected domain: ", $Domain, " and domain controller: ", $DomainController -Color White, Yellow, White, Yellow
                } catch {
                    Write-Color -Text "Detected domain: ", $Domain, " but couldn't detect domain controller. Please provide one: " -NoNewLine
                    $DomainController = Read-Host #-Prompt 'Domain Controller DNS name or IP Address'
                }
            }
        }
        if (-not $UserName) {
            Write-Color -Text "Please provide username you would like to change password for: " -Color Yellow -NoNewLine
            $UserName = Read-Host
            if (-not $UserName) {
                Write-Color -Text "Password change for account failed. ", "Username not provided." -Color Gray, Red, Gray, Red
                $Failed = $true
            }
        }
        if (-not $OldPassword) {
            Write-Color -Text "Please provide old password: " -Color Yellow -NoNewLine
            $OldPassword = Read-Host -AsSecureString
            $OldPasswordPlain = [System.Net.NetworkCredential]::new([string]::Empty, $OldPassword).Password
        }
        if (-not $NewPassword) {
            Write-Color -Text "Please provide new password: " -Color Yellow -NoNewLine
            $NewPassword = Read-Host -AsSecureString
            $NewPasswordPlain = [System.Net.NetworkCredential]::new([string]::Empty, $NewPassword).Password
            Write-Color -Text "Please provide new password again: " -Color Yellow -NoNewLine
            $NewPasswordCheck = Read-Host -AsSecureString
            $NewPasswordCheckPlain = [System.Net.NetworkCredential]::new([string]::Empty, $NewPasswordCheck).Password
            if ($NewPasswordCheckPlain -ne $NewPasswordPlain) {
                Write-Color -Text "New passwords don't match. Password change for account ", $UserName, " failed." -Color Gray, Red, Gray
                $Failed = $true
            }
        }
    }
    Process {
        if ($Failed) {
            return
        } elseif ($DomainController -and $OldPassword -and $NewPassword -and $UserName) {
            $DllImport = @'
[DllImport("netapi32.dll", CharSet = CharSet.Unicode)]
public static extern bool NetUserChangePassword(string domain, string username, string oldpassword, string newpassword);
'@
            try {
                $NetApi32 = Add-Type -MemberDefinition $DllImport -Name 'NetApi32' -Namespace 'Win32' -PassThru -ErrorAction Stop
            } catch {
                Write-Color -Text "Password change for account ", $UserName, " failed. Error: ", $_.Exception.Message -Color Gray, Red, Gray, Red
                return
            }

            if (-not $NoConfirm) {
                Write-Color -Text "You're about to change password for account ", $UserName, " on domain ", $Domain, " using domain controller ", $DomainController, ". " -Color Gray, Yellow, Gray, Yellow, Gray, Yellow
                Write-Color
                Write-Color -Text "Please press Y to approve change, or N to prevent password change and confirm with ENTER: " -Color Magenta -NoNewLine
                $Confirm = Read-Host
                if ($Confirm -ne 'Y') {
                    Write-Color -Text "Password change for account ", $UserName, " aborted." -Color Gray, Red, Gray
                    return
                }
            }
            $result = $NetApi32::NetUserChangePassword($DomainController, $UserName, $OldPasswordPlain, $NewPasswordPlain)
            if ($result) {
                Write-Color -Text "Password change for account ", $UserName, " failed on $DomainController." -Color Gray, Red, Gray, Red
            } else {
                Write-Color -Text "Password change for account ", $UserName, " succeeded on $DomainController." -Color Gray, Green, Gray, Green
            }
        } else {
            Write-Color -Text "Password change for account failed. All parameters are required. " -Color Red
        }
    }
    End {
        $OldPassword = $null
        $OldPasswordPlain = $null
        $NewPassword = $null
        $NewPasswordPlain = $null
        $NewPasswordCheck = $null
        $NewPasswordCheckPlain = $null
        [System.GC]::Collect()
    }
}