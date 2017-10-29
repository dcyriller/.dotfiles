# Clone .dotfiles

Clone dotfiles from github:
`git clone git@github.com:dcyriller/.dotfiles.git ~/.dotfiles`

Run `cp gitconfig ~/.gitconfig` to create a local copy git config.


# Use RCM

Install RCM from https://github.com/thoughtbot/rcm

Use it co symlink dotfiles from ~/.dotfiles to ~/.

`lsrc` will do a dry-run

`rcup -v -x README.md` will create the symlinks (verbose mode, excluding README).

It symlinks zsh and shell config. Plus vim.


# Scripts

The scripts directory contains some installation scripts.

`ìnstall_homebrew` will install main packages after a fresh macOS install.
`install_js_packages` will install (globally) some usefull js packages.

These scripts should be sourced in PATH if RCM step was successfull.


# VIM / NEOVIM

The config should work on both vim and neovim.

It is configured to use vim-plug.
It can be installed here https://github.com/junegunn/vim-plug

Then run `:PlugInstall`