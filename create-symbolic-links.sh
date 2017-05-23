#!/bin/bash

if [ -e ~/.bashrc]; do
    rm ~/.bashrc
done

if [ -e ~/.vimrc]; do
    rm ~/.vimrc
done

if [ -e ~/.zshrc]; do
    rm ~/.zshrc
done

if [ -e ~/.spacemacs]; do
    rm ~/.spacemacs
done

ln -s ~/git-repos/dotfiles/.bsahrc ~/.bashrc
ln -s ~/git-repos/dotfiles/.vimrc ~/.vimrc
ln -s ~/git-repos/dotfiles/.spacemacs ~/.spacemacs
ln -s ~/git-repos/dotfiles/.zshrc ~/.zshrc
