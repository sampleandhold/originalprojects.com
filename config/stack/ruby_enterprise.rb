package :ruby_enterprise do
  description 'Ruby Enterprise Edition'
  version '1.8.7-2009.10'

  install_path = "/usr/local/ruby-enterprise"
  binaries = %w(erb gem irb passenger-config passenger-install-apache2-module passenger-install-nginx-module passenger-make-enterprisey passenger-memory-stats passenger-spawn-server passenger-status passenger-stress-test rackup rails rake rdoc ree-version ri ruby testrb)
  source "http://rubyforge.org/frs/download.php/66162/ruby-enterprise-#{version}.tar.gz" do
    custom_install 'sudo ./installer --auto=/usr/local/ruby-enterprise'

    binaries.each {|bin| post :install, "ln -s #{install_path}/bin/#{bin} /usr/local/bin/#{bin}" }
  end

  verify do
    has_directory install_path
    has_executable "#{install_path}/bin/ruby"
    binaries.each {|bin| has_symlink "/usr/local/bin/#{bin}", "#{install_path}/bin/#{bin}" }
  end

  requires :ree_dependencies
end

package :ree_dependencies do
  apt %w(zlib1g-dev libreadline5-dev libssl-dev)
end
