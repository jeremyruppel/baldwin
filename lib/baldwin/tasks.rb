require 'appraisal'

include Rake::DSL

namespace :baldwin do

  desc "Set up current environment variables"
  task :env do
    require 'rails/version'
    ENV[ 'BALDWIN_RAILS_NAME' ] = "rails-#{Rails::VERSION::STRING}"
    ENV[ 'BALDWIN_RAILS_PATH' ] = "spec/rails/#{ENV[ 'BALDWIN_RAILS_NAME' ]}"
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
      sh "bundle exec rails new #{ENV[ 'BALDWIN_RAILS_PATH' ]} -m spec/support/rails_template.rb"
    end
  end
end