def setup_git!
  git :init
  git add: "-A ."
  git commit: "-n -m 'Creates initial project with saas_monkey'"

  if repo_specified?
    git remote: "add origin #{git_repo_url}"
    git push: "-u origin --all"
  end
end

def repo_specified?
  @repo_specified ||= ask_with_default('Do you have a git remote setup?', :white, 'n') \
    =~ /^y(es)?/i
end

def git_repo_url
  @git_repo_url ||= ask_with_default('Enter the url:', :white, '')
end

setup_git!
