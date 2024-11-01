# Notion Calendar Electron

A simple Electron-based Notion Calendar client

<div align="center">

![](https://img.shields.io/github/last-commit/czlabinger/nixos?&style=for-the-badge&color=FFB1C8&logoColor=D9E0EE&labelColor=292324)
![](https://img.shields.io/github/stars/czlabinger/nixos?style=for-the-badge&logo=andela&color=FFB686&logoColor=D9E0EE&labelColor=292324)
![](https://img.shields.io/github/repo-size/czlabinger/nixos?color=CAC992&label=SIZE&logo=googledrive&style=for-the-badge&logoColor=D9E0EE&labelColor=292324)
![](https://img.shields.io/badge/issues-skill-green?style=for-the-badge&color=CCE8E9&logoColor=D9E0EE&labelColor=292324)

</div>

## Installation

### Arch
#### yay
```bash
yay -S notion-calendar-electron
```

#### paru
```bash
paru -S notion-calendar-electron
```

### NixOS
#### Using Flakes
Add Notion Calendar Electron to your flakes inputs:
```nix
inputs.notion-calendar-electron.url = "github:czlabinger/notion-calendar-electron";
```

Install it:
```nix
environment.systemPackages = with pkgs; [
  inputs.notion-calendar-electron.packages.${pkgs.system}.default
];
```
