function pyactivate --wraps='source ./.venv/bin/activate.fish' --description 'alias pyactivate source ./.venv/bin/activate.fish'
  source ./.venv/bin/activate.fish $argv
end
