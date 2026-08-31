# My personal Nix Flake

<img
src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nix-snowflake-colours.svg"
align="right" alt="Nix logo" width="150">

> This is my Nix flake. There are many like it, but this one is mine.
>
> My Nix flake is my best friend. It is my life. I must master it as I must
> master my life.
>
> Without me, my Nix flake is useless. Without my Nix flake, I am useless. I
> must configure my Nix flake true. I must build more reproducibly than my
> computer who is trying to deceive me. I must configure it before it deceives
> me. I will ...
>
> My Nix flake and I know that what counts in IT is not the amount of words we
> type, the noise of our keyboard, nor the outputs we make. We know that it is
> the derivations that count. We will derive ...
>
> My Nix flake is human, even as I am human, because it is my life. Thus, I
> will learn it as a brother. I will learn its weaknesses, its strength, its
> code, its tooling, its inputs and outputs. I will keep my Nix flake clean and
> ready, even as I am clean and ready. We will become part of each other. We
> will ...
>
> Before God, I swear this creed. My Nix flake and I are the defenders of
> reliability. We are the masters of reproducibility. We are the saviors of my
> life.
>
> So be it, until victory is reproducible and there is no uncertainty, but
> peace!
>
> — [NixOS User's Creed](https://github.com/ners/NixOS)

## Overview

This is my personal Nix flake.
It was heavily organized and structured to be used mainly by me, though customizations are easy for those who understand Nix.

It uses home-manager as a NixOS module.

## Installation

```
git clone https://github.com/matkijahenkilo/dotfiles
cd dotfiles
direnv allow
```

### Host configuration

If building for the first time:

```
nixos-rebuild switch --flake .#hostname
```

If rebuilding a system, it uses the default hostname, so use `nh` because it's pretty:

```
nh os switch
```

## Cool commands for my usecase:

Build in machine A, deploy config to machine B via ssh (requires `ssh-copy-id`)

Useful for uploading configs to slow computers that can't build NixOS systems, like Raspberry Pi.

```
nixos-rebuild switch --sudo --ask-sudo-password --build-host localhost --target-host remote.server --flake /path/to/flake#remotehostname
```

Templates for projects

```
nix flake init --template /path/to/flake#template
```
