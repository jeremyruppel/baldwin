require 'thor/group'

module Baldwin
  class Installer < Thor::Group
    include Thor::Actions

    def ignore_dummy_rails_apps
      append_to_file '.gitignore', <<-EOS
spec/rails/rails-*
EOS
    end

    def create_appraisals_file
      create_file 'Appraisals', <<-EOS
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

    def add_baldwin_setup_to_spec_helper
      create_file 'spec/spec_helper.rb', <<-EOS
require 'baldwin/setup'
# require test dependencies *after* baldwin/setup
EOS
    end

    def copy_example_rails_template
      copy_file 'rails_template.rb', 'spec/rails/rails_template.rb'
    end

    def self.source_root
      File.dirname __FILE__
    end
  end
end
