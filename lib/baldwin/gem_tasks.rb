require 'appraisal'
require 'baldwin'
require 'rspec/core/rake_task'

include Rake::DSL

namespace :baldwin do

  desc "Set up current environment variables"
  task :env do
    Baldwin.env!
  end

  desc "Remove all test rails apps"
  task :clean => [ :env ] do
    Dir[ 'spec/rails/rails-*' ].each do |app|
      FileUtils.rm_rf app
    end
  end

  desc "Create a test rails app if necessary"
  task :rails => [ :env ] do
    if File.exist? ENV[ 'BALDWIN_RAILS_PATH' ]
      puts "Using existing #{ENV[ 'BALDWIN_RAILS_NAME' ]} app"
    else
      sh "bundle exec rails new #{ENV[ 'BALDWIN_RAILS_PATH' ]} -m spec/rails/rails_template.rb"
    end
  end

  desc "Install testing awesomeness"
  task :install do
    Baldwin::Installer.start
  end
end

RSpec::Core::RakeTask.new :rspec => [ :'baldwin:env', :'baldwin:rails' ]

desc "Run specs for all supported rails versions"
task :spec => :rspec

desc "Default: Clean, install dependencies, and run specs"
task :default => [ :'baldwin:clean', :'appraisal:install', :spec ]
