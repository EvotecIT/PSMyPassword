function Protect-MyPassword {
    param (
        [string] $UserName,
        [string] $Password,
        [alias('FilePath')][string] $Path,
        [string] $Output = 'File'
    )
    $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
    if ($Output -eq 'File') {
        $SecurePassword | Out-File -FilePath $Path

        $FullPath = Resolve-Path $Path
        if ($FullPath) {
            Write-Color -Text 'Get-SecurePassword', ' - ', 'secure file created in path ', $FullPath -Color Yellow, White, White, Yellow
        } else {
            Write-Color -Text 'Get-SecurePassword', ' - ', "can't find file at ", $FullPath -Color Yellow, White, White, Yellow
        }
    } elseif ($Output -eq 'Screen') {
        return $SecurePassword
    }
    return
}