# Apache SSL termination in virtual host for r10k_webhook
class profiles::r10k_webhook {
  $cert_file = "/etc/ssl/certs/${::fqdn}.crt.pem"
  $key_file  = "/etc/ssl/private/${::fqdn}.key.pem"

  file { '/etc/ssl/private':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0500',
  }

  file { $cert_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/r10k_webhook/cert.pem.erb"),
  }

  file { $key_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => template("${module_name}/r10k_webhook/key.pem.erb"),
  }

  class { 'apache':
    mpm_module    => 'prefork',
    default_vhost => false,
  }

  class { '::apache::mod::ssl':     }

  apache::vhost { 'r10k_webhook ssl':
    servername          => 'r10k_webhook',
    port                => '443',
    docroot             => '/var/www',
    default_vhost       => true,
    ssl                 => true,
    proxy_preserve_host => 'On',
    proxy_pass          => [
      {
        path => '/',
        url  => 'http://localhost:8088/',
      },
    ],
  }
}
