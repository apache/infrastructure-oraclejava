# Oracle Java Puppet Module
This module manages Oracle Java 8 and Java 7 with Unlimited JCE

This module has been tested against Puppet 3.8 on Ubuntu 14.04

Pull requests welcome

*NOTE:* This module may only be used if you agree to the Oracle license: http://www.oracle.com/technetwork/java/javase/terms/license/

### Usage

    include oraclejava::install
    
or

    class { 'oraclejava::install': }

The default behavior is to install java8 with unlimited JCE. It will not automatically upgrade. If you would like to upgrade java8, you can use the `ensure` parameter:

    class { 'oraclejava::install':
      ensure => 'latest'
    }

If you do not want unlimited JCE specify false:

    class { 'oraclejava::install':
      ensure        => 'latest'
      unlimited_jce => false;
    }


Hiera example:

---
classes:
  - oraclejava::install

oraclejava::install::unlimited_jce: true
oraclejava::install::version: '7' 

Keep in mind that the webupd8 team's java8 package does not keep historical versions of the java installer, so you cannot specify a specific version of java to install at this time.

### Author
* Chris Lambertus <clambertus@gmail.com> 

### Contributors:
* Scott Smerchek <scott.smerchek@softekinc.com>: this module is based heavily on and includes parts of softek/puppet-java7
* flosell: Added Debian 6 support
