# Java8 Puppet Module
This module manages Oracle Java8.

This module has been tested against 3.0.1 on Ubuntu 12.04 and Debian 6.

Pull requests to add support for other operating systems are welcome.

*NOTE:* This module may only be used if you agree to the Oracle license: http://www.oracle.com/technetwork/java/javase/terms/license/

### Usage

    include java8
    
or

    class { 'java8': }

The default behavior is to install java8. It will not automatically upgrade. If you would like to upgrade java8, you can use the `ensure` parameter:

    class { 'java8':
      ensure => 'latest'
    }

Keep in mind that the webupd8 team's java8 package does not keep historical versions of the java installer, so you cannot specify a specific version of java to install at this time.

### Author
* Scott Smerchek <scott.smerchek@softekinc.com>

### Contributors:
* flosell: Added Debian 6 support
