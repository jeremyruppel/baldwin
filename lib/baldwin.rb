require 'baldwin/version'

module Baldwin
  autoload :Installer, 'baldwin/installer'

  RAILS_PATTERN = 'spec/rails/rails-*'

  def self.env!
    require 'rails/version'
    ENV[ 'BALDWIN_RAILS_NAME' ] = "rails-#{Rails::VERSION::STRING}"
    ENV[ 'BALDWIN_RAILS_PATH' ] = "spec/rails/#{ENV[ 'BALDWIN_RAILS_NAME' ]}"
  end

  def self.root
    Pathname.new Dir.pwd
  end

  def self.rails
    root.join ENV[ 'BALDWIN_RAILS_PATH' ]
  end

  def self.apps
    Dir[ RAILS_PATTERN ]
  end
end
