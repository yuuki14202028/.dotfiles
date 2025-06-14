# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.
常に日本語で返答してください。

## Repository Overview

This is a NixOS dotfiles repository using Nix Flakes and Home Manager for declarative system configuration. The repository manages a complete NixOS system including desktop environment (KDE Plasma 6), development tools, Japanese localization, and gaming setup.

## Essential Commands

- `nrs` - Rebuild and switch NixOS configuration from dotfiles (equivalent to `sudo nixos-rebuild switch --flake .#myNixOS`)
- `nix develop` - Enter development shell with Node.js, Prisma, and npm
- `nix flake update` - Update all flake inputs to latest versions
- `home-manager switch --flake .` - Apply home-manager configuration changes

## Architecture

### Core Configuration Files
- `flake.nix` - Main flake configuration defining system inputs, outputs, and development environment
- `configuration.nix` - System-level NixOS configuration (hardware, services, system packages)
- `home.nix` - Home Manager configuration importing all user-space modules

### Modular Structure
Each tool/service has its own `.nix` file:
- `zsh.nix` - Zsh shell with modern CLI tools (bat, eza, ripgrep)
- `starship.nix` + `starship.toml` - Shell prompt configuration
- `jetbrains.nix` - Complete JetBrains IDE setup with plugins
- `vim.nix` - Neovim configuration
- `git.nix` - Git and GitHub CLI setup
- `apps.nix` - Desktop applications
- `browser.nix` - Browser configuration

### Key Features
- **Reproducible Environment**: Everything declared in Nix expressions
- **Japanese Support**: Full Japanese locale and Fcitx5 + Mozc IME
- **Gaming Ready**: Steam, NVIDIA drivers, hardware acceleration
- **Development Focus**: Multiple IDEs, modern CLI tools, automated development shell

## Development Workflow

1. Make changes to relevant `.nix` files
2. Test configuration with `nrs` command
3. Use `nix flake update` to update dependencies when needed
4. Development environment automatically available via direnv or `nix develop`

## Important Notes

- System uses nixpkgs-unstable channel for latest packages
- Hardware configuration includes NVIDIA GPU and Logitech device support
- All user applications managed through Home Manager modules
- Custom aliases: `cat`→`bat`, `ls`→`eza`, `grep`→`rg`
