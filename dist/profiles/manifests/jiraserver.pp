# Jira Server configuration
class profiles::jiraserver {
  include ::jira

  $cert_file = "/etc/ssl/certs/${::fqdn}.crt.pem"
  $key_file  = "/etc/ssl/private/${::fqdn}.key.pem"

  file { '/opt/atlassian':
    ensure => 'directory',
    owner  => 'jira',
    group  => 'jira',
    mode   => '0755',
  }

  file { $cert_file:
    ensure  => 'present',
    user    => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/jira/cert.pem.erb"),
  }

  file { $key_file:
    ensure  => 'present',
    user    => 'root',
    group   => 'ssl-cert',
    mode    => '0400',
    content => template("${module_name}/jira/key.pem.erb"),
  }


  class { 'apache':
    mpm_module    => 'prefork',
    default_vhost => false,
  }

  class { 'apache::mod::rewrite': }
  class { 'apache::mod::ssl':     }
  class { 'postgresql::server':   }

  apache::vhost { 'jira non-ssl':
    servername => 'jira',
    port       => '80',
    docroot    => '/var/www',
    rewrites   => [
      {
        comment      => 'redirect to https',
        rewrite_cond => ['%{HTTPS} off'],
        rewrite_rule => '(.*) https://%{HTTP_HOST}:443%{REQUEST_URI}'],
      },
    ],
  }

  apache::vhost { 'jira ssl':
    servername          => 'jira',
    port                => '443',
    docroot             => '/var/www',
    default_vhost       => true,
    ssl                 => true,
    proxy_preserve_host => 'On',
    proxy_pass          => [
      {
        path => '/',
        url  => 'http://localhost:8080/',
      },
    ],
    require             => Apache::Vhost ['jira non-ssl'],
  }


  postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => hiera('jiradb_pass'),
  }
}
