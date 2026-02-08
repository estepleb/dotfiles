# dotfiles

My dotfiles, managed with chezmoi.

Currently running CachyOS + Niri + DankMaterialShell, but I have previously used Hyprland, MangoWC, and Noctalia Shell. 

First, install chezmoi, for example via:

```
sh -c "$(curl -fsLS get.chezmoi.io/lb)"
```

Then, init, verify the diff, and apply:

```
chezmoi init https://github.com/estepleb/dotfiles.git
chezmoi diff
chezmoi apply
```

The before-chezmoi tag points at the last commit before switching to chezmoi.
