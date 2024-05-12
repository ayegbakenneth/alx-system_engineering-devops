# Install and enable Apache package
package { 'apache2':
  ensure => installed,
}

# Ensure Apache service is running and enabled
service { 'apache2':
  ensure  => running,
  enable  => true,
  require => Package['apache2'],
}

# Modify Apache configuration
file { '/etc/apache2/apache2.conf':
  ensure  => present,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => template('your_module_name/apache2.conf.erb'),
  require => Package['apache2'],
  notify  => Service['apache2'],
}

# Enable necessary Apache modules
apache::mod { 'rewrite':
  ensure => present,
  before => File['/etc/apache2/apache2.conf'],
  require => Package['apache2'],
  notify => Service['apache2'],
}

apache::mod { 'headers':
  ensure => present,
  before => File['/etc/apache2/apache2.conf'],
  require => Package['apache2'],
  notify => Service['apache2'],
}

# Restart Apache service if configuration changes
exec { 'restart_apache2':
  command     => '/usr/sbin/service apache2 restart',
  refreshonly => true,
  subscribe   => File['/etc/apache2/apache2.conf'],
}
