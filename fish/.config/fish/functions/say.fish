function say --wraps='espeak -p 10 -s 150 -a 200 2> /dev/null' --description 'alias say espeak -p 10 -s 150 -a 200 2> /dev/null'
  espeak -p 10 -s 150 -a 200 2> /dev/null $argv
end
