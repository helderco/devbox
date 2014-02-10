
python-mysqldb:
  pkg:
    - installed

rubygems:
  pkg:
    - installed

compass:
  gem:
    - installed

npm -g install less:
  cmd:
    - run
    - unless: npm -g list less
