class profiles::jiraserver (
  $certificate,
  $jiradb_pass,
  $private_key,
) {
  include ::java
  include ::jira
  include ::jira::facts

  $cert_file = "/etc/ssl/certs/${::fqdn}.crt.pem"
  $key_file  = "/etc/ssl/private/${::fqdn}.key.pem"

  File {
    ensure => present,
    owner  => 'root',
  }

  class { 'apache':
    mpm_module    => 'prefork',
    default_vhost => false,
  }

  class { 'apache::mod::rewrite':
  }

  class { 'apache::mod::ssl':
  }

  apache::vhost { 'jira non-ssl':
    servername => 'jira',
    port       => '80',
    docroot    => '/var/www',
    rewrites   => [
      {
        comment      => 'redirect to https',
        rewrite_cond => ['%{HTTPS} off'],
        rewrite_rule => ['(.*) https://%{HTTP_HOST}:443%{REQUEST_URI}'],
      },
    ],
  }

  apache::vhost { 'jira ssl':
    servername          => 'jira',
    port                => '443',
    docroot             => '/var/www',
    default_vhost       => true,
    ssl                 => true,
    ssl_cert            => $cert_file,
    ssl_key             => $key_file,
    proxy_preserve_host => 'On',
    proxy_pass          => [ {
      'path' => '/',
      'url'  => 'http://localhost:8080/' },
    ],
    require             => Apache::Vhost [ 'jira non-ssl']
  }

  file { $cert_file:
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/jira/crt.pem.erb"),
  }

  file { $key_file:
    group   => 'ssl-cert',
    mode    => '0400',
    content => template("${module_name}/jira/key.pem.erb"),
  }

  class {'postgresql::server': }

  file { '/opt/atlassian':
    ensure => 'directory',
    owner  => 'jira',
    group  => 'jira',
    mode   => '0755',
  }

  postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => $jiradb_pass,
  }
}
