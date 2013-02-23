# Install Alloy's MacVim fork which provides a fancy sidebar
#
# Examples
#
#   include macvim-alloy

class macvim-alloy {
  include homebrew
  include homebrew::config
  
  $version = '7.3-66-boxen1'
  
  homebrew::formula { 'macvim':
    before => Package['boxen/brews/macvim']
  }
  
  package { 'boxen/brews/macvim':
    ensure => $version
  }
  
  file { '/Applications/MacVim.app':
    ensure  => 'link',
    target  => "${homebrew::config::installdir}/Cellar/macvim/${version}/MacVim.app",
    require => 
    [
      Package['boxen/brews/macvim'],
      File["${homebrew::config::installdir}/Cellar/macvim/${version}"]
    ]
  }
  
  file { "${homebrew::config::installdir}/Cellar/macvim/${version}":
    ensure  => directory,
    require => Package['boxen/brews/macvim']
  }
}