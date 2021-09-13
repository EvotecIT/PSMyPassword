---
external help file: PSMyPassword-help.xml
Module Name: PSMyPassword
online version:
schema: 2.0.0
---

# Set-MyPassword

## SYNOPSIS
Allows the user to change the password of the Active Directory account using PowerShell, including when the password is expired.

## SYNTAX

```
Set-MyPassword [-UserName <String>] [-OldPassword <SecureString>] [-NewPassword <SecureString>]
 [-DomainController <String>] [-Domain <String>] [-NoConfirm] [<CommonParameters>]
```

## DESCRIPTION
Allows the user to change the password of the Active Directory account using PowerShell, including when the password is expired.
This command can be run on a computer outside of the domain and doesn't require any special permissions.

## EXAMPLES

### EXAMPLE 1
```
Set-MyPassword
```

### EXAMPLE 2
```
Set-MyPassword -UserName "svc_test" -DomainController "ad1.ad.evotec.xyz"
```

## PARAMETERS

### -UserName
Provide username to change password for.
If not provided user will be prompted to provide one

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OldPassword
Provide old password for the user.
If not provided user will be prompted to provide one

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewPassword
Provide new password for the user.
If not provided user will be prompted to provide one

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DomainController
Provide DomainController name or ip address.
If user doesn't provide Domain Controller name, the command will try to find it automatically (if computer is part of the domain)

```yaml
Type: String
Parameter Sets: (All)
Aliases: DC, Server, ComputerName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
Provide Domain name.
If user doesn't provide Domain name, the command will try to find it automatically (if computer is part of the domain)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoConfirm
{{ Fill NoConfirm Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
