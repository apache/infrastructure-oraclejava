# Class: java8
#
# This module manages Oracle Java8
# Parameters: none
# Requires:
#  apt
# Sample Usage:
#  include java8
class java8 (
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
      package { 'oracle-java8-installer':
        ensure       => $ensure,
        responsefile => '/tmp/java.preseed',
        require      => [
                          Apt::Source['webupd8team'],
                          File['/tmp/java.preseed']
                        ],
      }
   }
   ubuntu: {
     include apt

      apt::ppa { 'ppa:webupd8team/java': }
      package { 'oracle-java8-installer':
        ensure       => $ensure,
        responsefile => '/tmp/java.preseed',
        require      => [
                          Apt::Ppa['ppa:webupd8team/java'],
                          File['/tmp/java.preseed']
                        ],
      }
      package { 'oracle-java8-unlimited-jce-policy':
        ensure       => $ensure,
        responsefile => '/tmp/java.preseed',
        require      => [
                          Apt::Ppa['ppa:webupd8team/java'],
                          File['/tmp/java.preseed']
                        ],
      }
   }
   default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
 }

  case $::operatingsystem {
    debian, ubuntu: {
      file { '/tmp/java.preseed':
        source => 'puppet:///modules/java8/java.preseed',
        mode   => '0600',
        backup => false,
      }
    }
    default: { notice "Unsupported operatingsystem ${::operatingsystem}" }
  }
}
