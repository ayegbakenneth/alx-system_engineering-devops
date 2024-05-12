file { '/etc/apache2/conf.d/error-500.conf':
  ensure  => present,
  content => ErrorDocument 500 "Internal Server Error"
}

service { 'apache2':
  ensure => 'running',
  enable => true,
  require => File['/etc/apache2/conf.d/error-500.conf'],
}
