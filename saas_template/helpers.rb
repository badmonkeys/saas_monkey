$repo_url = 'https://raw.githubusercontent.com/badmonkeys/bad_monkey_rails/master'

def remove_comments_for(filename)
  gsub_file filename, /^\s*#.*\n/, ''
end

def append_to_file(filename, contents)
  open(filename, 'a') {|f| f.puts contents }
end

def repo_get(path)
  get "#{$repo_url}/#{path}", path
end

