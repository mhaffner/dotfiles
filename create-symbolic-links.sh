#!/bin/bash

rm ~/.bashrc
#rm ~/.vimrc
#rm ~/.spacemacs
rm ~/.zshrc

ln -s ~/git-repos/dotfiles/.bsahrc ~/.bashrc
ln -s ~/git-repos/dotfiles/.vimrc ~/.vimrc
ln -s ~/git-repos/dotfiles/.spacemacs ~/.spacemacs
ln -s ~/git-repos/dotfiles/.zshrc ~/.zshrc
