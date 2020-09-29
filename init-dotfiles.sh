set -e

git clone https://github.com/$USER/$REPO ~/dotfiles
cd ~/dotfiles

git submodule init
git submodule update

dotfilesDir=~/dotfiles

function linkDotfile {
  dest="${HOME}/${1}"
  dateStr=$(date +%Y-%m-%d-%H%M)

  if [ -h ~/${1} ]; then
    # Existing symlink 
    echo "Removing existing symlink: ${dest}"
    rm ${dest} 

  elif [ -f "${dest}" ]; then
    # Existing file
    echo "Backing up existing file: ${dest}"
    mv ${dest}{,.${dateStr}}

  elif [ -d "${dest}" ]; then
    # Existing dir
    echo "Backing up existing dir: ${dest}"
    mv ${dest}{,.${dateStr}}
  fi

  echo "Creating new symlink: ${dest}"
  ln -s ${dotfilesDir}/${1} ${dest}
}

linkDotfile .vim
linkDotfile .vimrc
linkDotfile .ackrc
linkDotfile .bashrc
linkDotfile .bash_aliases
linkDotfile .gitconfig
linkDotfile .tmux.conf
linkDotfile .goomwwmrc
linkDotfile .inputrc
linkDotfile .xinitrc
linkDotfile .curlrc
linkDotfile .gf