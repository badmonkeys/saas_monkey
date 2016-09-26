run 'rm -rf test/'
copy_file 'rspec', '.rspec'
copy_file 'spec/rails_helper.rb', force: true
copy_file 'spec/spec_helper.rb', force: true

apply('spec/support/template.rb')
