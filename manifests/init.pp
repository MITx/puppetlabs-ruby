# Class: ruby
#
# This class installs Ruby
#
# Parameters:
#
# Actions:
#   - Install Ruby
#   - Install Ruby Gems
#
# Requires:
#
# Sample Usage:
#
class ruby {

  include ruby::params

  package { [ 'ruby1.9.1', 'ruby1.9.1-dev', 'ri1.9.1', 'build-essential', 'libssl-dev', 'zlib1g-dev' ]:
    ensure => installed,
    notify => Exec['change-ruby-version'],
  }

  exec { 'change-ruby-version':
    command     => 'update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 400 --slave   /usr/share/man/man1/ruby.1.gz ruby.1.gz /usr/share/man/man1/ruby1.9.1.1.gz --slave   /usr/bin/ri ri /usr/bin/ri1.9.1 --slave   /usr/bin/irb irb /usr/bin/irb1.9.1 --slave   /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.1',
    refreshonly => true,
    require     => Package['ruby1.9.1'],
    notify      => [ Exec['alt-ruby'], Exec['alt-gem'] ],
  }

  exec { 'alt-ruby':
    command     => 'update-alternatives --auto ruby',
    refreshonly => true,
  }

  exec { 'alt-gem':
    command     => 'update-alternatives --auto gem', 
    refreshonly => true,
  }

}
