if status is-interactive
    #because fish_add_path realpaths the input, anything relative to home must
    #be done globably instead of universallly.
    fish_add_path -g ~/.local/bin/
    fish_add_path -g ~/.cargo/bin/
    if type -q pyenv
        set -gx PYENV_ROOT $HOME/.pyenv
        fish_add_path -g $PYENV_ROOT/bin
        pyenv init - | source
    end
    type -q zoxide; and zoxide init fish | source
    type -q starship; and starship init fish | source
    #ssh-agent systemd service
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end
