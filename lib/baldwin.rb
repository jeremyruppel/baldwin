require 'baldwin/version'

module Baldwin
  autoload :Installer, 'baldwin/installer'

  def self.env!
    require 'rails/version'
    ENV[ 'BALDWIN_RAILS_NAME' ] = "rails-#{Rails::VERSION::STRING}"
    ENV[ 'BALDWIN_RAILS_PATH' ] = "spec/rails/#{ENV[ 'BALDWIN_RAILS_NAME' ]}"
  end

  def self.root
    Pathname.new Dir.pwd
  end

  def self.rails
    Pathname.new ENV[ 'BALDWIN_RAILS_PATH' ]
  end
end
