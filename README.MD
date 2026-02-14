<p align="center">
  <a href="https://dev.azure.com/evotecpl/PSMyPassword/_build/results?buildId=latest"><img src="https://dev.azure.com/evotecpl/PSMyPassword/_apis/build/status/EvotecIT.PSMyPassword"></a>
  <a href="https://www.powershellgallery.com/packages/PSMyPassword"><img src="https://img.shields.io/powershellgallery/v/PSMyPassword.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSMyPassword"><img src="https://img.shields.io/powershellgallery/v/PSMyPassword.svg?label=powershell%20gallery%20preview&colorB=yellow&include_prereleases"></a>
  <a href="https://github.com/EvotecIT/PSMyPassword"><img src="https://img.shields.io/github/license/EvotecIT/PSMyPassword.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/PSMyPassword"><img src="https://img.shields.io/powershellgallery/p/PSMyPassword.svg"></a>
  <a href="https://github.com/EvotecIT/PSMyPassword"><img src="https://img.shields.io/github/languages/top/evotecit/PSMyPassword.svg"></a>
  <a href="https://github.com/EvotecIT/PSMyPassword"><img src="https://img.shields.io/github/languages/code-size/evotecit/PSMyPassword.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSMyPassword"><img src="https://img.shields.io/powershellgallery/dt/PSMyPassword.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# PSMyPassword - PowerShell Module

This little PowerShell module provides a simple way to change password of any user account if you know it. This is very useful for situations when you can't login to RDP


With this command you can change password of any user account, as long as you have password. The account can be service account and expired.

```powershell
Set-MyPassword -UserName 'test'
```

With this command you can encrypt the password for use within a script.

```powershell
Protect-MyPassword -UserName 'test'
```

With this command you can test if given login and password are valid.

```powershell
Test-MyPassword
```

Blog post describing use cases: https://evotec.xyz/how-to-change-your-own-expired-password-when-you-cant-login-to-rdp/

## Installing

Everyone can install this module from **PowerShellGallery** hosted by Microsoft. It's recommended way to work with the module.
Version on **PowershellGallery** is optimized for speed and signed. Using code from **GitHub** is **recommended for development**.

```powershell
Install-Module -Name PSMyPassword -AllowClobber -Force
```

Force and AllowClobber aren't necessary, but they do skip errors in case some appear.

## Updating

```powershell
Update-Module -Name PSMyPassword
```

That's it. Whenever there's a new version, you run the command, and you can enjoy it. Remember that you may need to close, reopen PowerShell session if you have already used module before updating it.

**The essential thing** is if something works for you on production, keep using it till you test the new version on a test computer. I do changes that may not be big, but big enough that auto-update may break your code. For example, small rename to a parameter and your code stops working! Be responsible!

## Changelog

 - 0.0.4 - 2021.09.13