FROM alpine:latest
MAINTAINER 'Oleg Sviridovitch <oleg.sviridovitch@gmail.com>'

ENV DEVUSER=olsv \
    DEVGROUP=stuff

ENTRYPOINT ["zsh"]

RUN apk --update add git htop man mc openssh-client tmux vim wget zsh
RUN addgroup ${DEVGROUP} && adduser -s /bin/zsh -D -G ${DEVGROUP} ${DEVUSER}
WORKDIR /home/${DEVUSER}
USER ${DEVUSER}
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
    git clone https://github.com/flazz/vim-colorschemes.git ~/.vim && \
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    git clone https://github.com/olsv/.dotfiles.git ~/.dotfiles && \
    rm -rf ~/.dotfiles/.git && cp -r ~/.dotfiles/. ~ && rm -rf ~/.dotfiles && \
    vim +PluginInstall +qall

