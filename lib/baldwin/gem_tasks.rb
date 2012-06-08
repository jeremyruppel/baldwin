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
    Baldwin.apps.each { |app| app.rmdir :force => true }
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

desc "Start up a dummy application"
task :server => :'baldwin:env' do
  APP_PATH = Baldwin.rails.join 'config/application'
  require Baldwin.rails.join 'config/boot'
  require 'rails/commands' # this automatically runs 'rails server'
end

RSpec::Core::RakeTask.new :rspec => [ :'baldwin:env', :'baldwin:rails' ]

desc "Run specs for all supported rails versions"
task :spec => :rspec

desc "Default: Clean, install dependencies, and run specs"
task :default => [ :'baldwin:clean', :'appraisal:install', :spec ]
