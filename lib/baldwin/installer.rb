require 'thor/group'

module Baldwin
  class Installer < Thor::Group
    include Thor::Actions

    def ignore_dummy_rails_apps
      append_file '.gitignore', <<-EOS
#{byline}
spec/support/rails-*
EOS
    end

    def create_appraisals_file
      create_file 'Appraisals', <<-EOS
#{byline}
# add your rails configurations to test against here, like:
#
#   appraise 'rails-3.1.0' do
#     gem 'rails', '3.1.0'
#   end
#   appraise 'rails-3.2.0' do
#     gem 'rails', '3.2.0'
#   end
#
# see https://github.com/thoughtbot/appraisal for more info
EOS
    end

    def add_appraisal_rake_task
      comment_lines 'Rakefile', /RSpec::Core::RakeTask/

      append_file 'Rakefile', <<-EOS
#{byline}
RSpec::Core::RakeTask.new :spec => [ :'baldwin:env', :'baldwin:rails' ]

desc "Run specs for all supported rails versions"
task :all do
  exec 'rake appraisal spec'
end

desc "Default: Clean, install dependencies, and run specs"
task :default => [ :'baldwin:clean', :'appraisal:install', :all ]
EOS
    end

    def baz
      say "Did baz", :blue
    end

    protected

    def byline
      "# added by baldwin #{Baldwin::VERSION}"
    end
  end
end
