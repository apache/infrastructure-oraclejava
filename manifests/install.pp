# Class: oraclejava::install
#
# This module manages Oracle Java7 or Java8
# Parameters: version (7, 8), ulimited_jce (true, false)
# Requires:
#  apt
# Sample Usage:
#   oraclejava::install::version: 7
#   oraclejava::install::unlimited_jce: true
#   include oraclejava::install

class oraclejava::install (
  $version = '8', # allowed values 6, 7, 8
  $unlimited_jce = true,
  $include_src = true,
  $ensure = 'installed',
) {

  case $::operatingsystem {
    debian: {
      include apt
      apt::source { 'webupd8team': 
        location          => "http://ppa.launchpad.net/webupd8team/java/ubuntu",
        release           => "precise",
        repos             => "main",
        key               => "EEA14886",
        key_server        => "keyserver.ubuntu.com",
        include_src       => $include_src,
      }
      file { '/tmp/java.preseed':
        source => 'puppet:///modules/oraclejava/java.preseed',
        mode   => '0600',
        backup => false,
      }
    }
    ubuntu: {
      include apt
      apt::ppa { 'ppa:webupd8team/java': }
      file { '/tmp/java.preseed':
        source => 'puppet:///modules/oraclejava/java.preseed',
        mode   => '0600',
        backup => false,
      }
    }
    default: { 
      notice "Unsupported operatingsystem ${::operatingsystem}" 
    }
  }

  case $version {
    8: {
      $jdkpkg = 'oracle-java8-installer'
      $jcepkg = 'oracle-java8-unlimited-jce-policy'
    }
    7: {
      $jdkpkg = 'oracle-java7-installer'
      $jcepkg = 'oracle-java7-unlimited-jce-policy'
    }
    6: {
      $jdkpkg = 'oracle-java6-installer'
    }
    default: {
      notice "Invalid Java version"
    }
  }

  package { $jdkpkg:
    ensure       => $ensure,
    responsefile => '/tmp/java.preseed',
    require      => [
        Apt::Ppa['ppa:webupd8team/java'],
        Class['apt::update'],
        File['/tmp/java.preseed']
    ],
  }

  if $unlimited_jce {
    if $jcepkg {
      package { $jcepkg:
        ensure       => $ensure,
        responsefile => '/tmp/java.preseed',
        require      => [
          Apt::Ppa['ppa:webupd8team/java'],
          Class['apt::update'],
          File['/tmp/java.preseed']
        ],
      }
    }
  }
}

