def setup_git!
  after_bundle do
    git :init
    git add: "-A ."
    git commit: "-n -m 'Creates initial project with saas_monkey'"

    if @t_options[:remote]
      git remote: "add origin #{@t_options[:remote]}"
      git push: "-u origin --all"
    end
  end
end

setup_git!
