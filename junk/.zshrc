# Check if zplug is installed
 [[ -d ~/.zplug ]] || {
   git clone https://github.com/b4b4r07/zplug ~/.zplug
   source ~/.zplug/init.zsh && zplug update --self
 }

# Essencial
source ~/.zplug/init.zsh

# 「ユーザ名/リポジトリ名」で記述し、ダブルクォートで見やすく括る（括らなくてもいい）
zplug "zsh-users/zsh-history-substring-search"

# junegunn/dotfiles にある bin の中の vimcat をコマンドとして管理する
zplug "junegunn/dotfiles", as:command, use:bin/vimcat

# tcnksm/docker-alias にある zshrc をプラグインとして管理する
# as: のデフォルトは plugin なので省力もできる
zplug "tcnksm/docker-alias", use:zshrc, as:plugin

# frozen: を指定すると全体アップデートのときアップデートしなくなる（デフォルトは0）
zplug "k4rthik/git-cal", as:command, frozen:1

# from: で特殊ケースを扱える
# gh-r を指定すると GitHub Releases から取ってくる
# use: で amd64 とかするとそれを持ってくる（指定しないかぎりOSにあったものを自動で選ぶ）
# コマンド化するときに rename-to: でリネームできる（この例では fzf-bin を fzf にしてる）
zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:fzf

# from: では gh-r の他に oh-my-zsh と gist が使える
# oh-my-zsh を指定すると oh-my-zsh のリポジトリにある plugin/ 以下を
# コマンド／プラグインとして管理することができる
#zplug "plugins/git", from:oh-my-zsh #ロードエラーが発生する(compdiff) 
#zplug "themes/robbyrusell", from:oh-my-zsh

# ビルド用 hook になっていて、この例ではクローン成功時に make install する
# シェルコマンドなら何でも受け付けるので "echo OK" などでも可
zplug "tj/n", hook-build:"make install"

# ブランチロック・リビジョンロック
# at: はブランチとタグをサポートしている
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60

# if: を指定すると真のときのみロードを行う（クローンはする）
zplug "hchbaw/opp.zsh", if:"(( ${ZSH_VERSION%%.*} < 5 ))"

# from: では gist を指定することができる
# gist のときもリポジトリと同様にタグを使うことができる
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh

# bitbucket もまた同じように指定可能
zplug "b4b4r07/hello_bitbucket", \
    from:bitbucket, \
    as:command, \
    hook-build:"chmod 755 *.sh", \
    use:"*.sh"

# パイプで依存関係を表現できる
# 依存関係はパイプの流れのまま(最新版ではパイプは非推奨(deprecated))
# この例では emoji-cli は jq に依存する
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq
#ここでパイプを使って | zplug "b4b4r07/emoji-cli"とインストールするやり方は非推奨
zplug "b4b4r07/emoji-cli", \
    on:"stedolan/jq"
# Note: To specify the order in which packages should be loaded, use the nice
#       tag described in the next section

# ロードするときの優先順位をniceで設定
# e.g., zsh-syntax-highlighting は compinit や他の plugins をロードした後に読み込む必要がある
# compinit: http://www.shigemk2.com/entry/zsh.completion(zsh補完とcompinitとautoload)
zplug "zsh-users/zsh-syntax-highlighting", nice:10

## The other plugins if you needed
zplug "sorin-ionescu/prezto", from:github

# local plugins も管理できる
zplug "~/.zsh", from:local
# A relative path is resolved with respect to the $ZPLUG_HOME
zplug "~/.oh-my-zsh/plugins/bower", from:local
#zplug "repos/robbyrussell/oh-my-zsh/custom", from:local

# check コマンドで未インストール項目があるかどうか verbose にチェックし
# false のとき（つまり未インストール項目がある）y/N プロンプトで
# インストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose

### Custom ###
export EDITOR=emacs
export VISUAL=emacs

# Shell
export PATH="$PATH:$HOME/sh"

# Ruby
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.rvm/scripts/rvm

# python
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# added by travis gem
[ -f /Users/pncity/.travis/travis.sh ] && source /Users/pncity/.travis/travis.sh
