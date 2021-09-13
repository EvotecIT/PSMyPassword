function Protect-MyPassword {
    [cmdletBinding(DefaultParameterSetName = 'SecurePassword')]
    param (
        # [Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $false)][string] $UserName = 'ThisIsNotImportant',

        [Parameter(ParameterSetName = 'SecurePassword')][securestring] $Password,
        [Parameter(ParameterSetName = 'PlainTextPassword')][string] $PlainTextPassword,
        [Parameter()][alias('FilePath')][string] $Path,
        [validateset("File", 'Screen')][string] $Output = 'Screen',
        [string] $AsUserName,
        [string] $AsPassword
    )
    #if (($AsUserName) -and ($AsPassword)) {
    #    $SecurePassword = $AsPassword | ConvertTo-SecureString -AsPlainText -Force
    #    $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $AsUserName, $SecurePassword
    #    Invoke-Command -ComputerName $Env:COMPUTERNAME -Credential $Credentials -ScriptBlock {
    #        Write-Color "Test", ' ', $Env:USERNAME
    #    }
    #}
    #return
    <#
    if (-not $Password) {
        if ($UserName) {
            $SecureCredentials = Get-Credential -UserName $UserName -Message 'Please enter password to secure'
        } else {
            $SecureCredentials = Get-Credential -Message 'Please enter password to secure'
        }
        $SecurePassword = $SecureCredentials.Password | ConvertFrom-SecureString
    } else {
        $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    }
    #>
    if ($PlainTextPassword) {
        $SecurePassword = $PlainTextPassword | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    } elseif ($Password) {
        $SecurePassword = $Password | ConvertFrom-SecureString
    } else {
        Write-Color -Text "Please provide password you want to encrypt: " -Color Yellow -NoNewLine
        $Password = Read-Host -AsSecureString
        $SecurePassword = $Password | ConvertFrom-SecureString
    }

    if ($Output -eq 'File') {
        if ($Path -ne '') {
            $SecurePassword | Out-File -FilePath $Path

            $FullPath = Resolve-Path $Path
            if ($FullPath) {
                Write-Color -Text 'Protect-MyPassword', ' - ', 'secure file created in path ', $FullPath -Color Yellow, White, White, Yellow
            } else {
                Write-Color -Text 'Protect-MyPassword', ' - ', "can't find file at ", $FullPath -Color Yellow, White, White, Yellow
            }
        } else {
            Write-Color -Text 'Protect-MyPassword - File Path ', $Path, " is empty. Terminating." -Color White, Red, White
        }
    } elseif ($Output -eq 'Screen') {
        return $SecurePassword
    }
    return
}