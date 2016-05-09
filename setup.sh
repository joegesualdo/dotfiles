for entry in "$HOME/dotfiles"/*
do
  name=$(basename $entry);
  if [ "$name" != ".git" ] && \
    [ "$name" != ".gitignore" ] && \
    [ "$name" != "setup.sh" ] && \
    [ "$name" != "LICENSE" ] && \
    [ "$name" != "utilities" ] && \
    [ "$name" != "README.md" ] ;then
    ln -s $entry "$HOME/.$name"
  fi
done
