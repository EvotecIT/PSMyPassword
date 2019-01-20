function Protect-MyPassword {
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $false)][string] $UserName,
        [Parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $false)][string] $Password,
        [Parameter(Position = 2, Mandatory = $true, ValueFromPipeline = $false)][alias('FilePath')][string] $Path,
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
    $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
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