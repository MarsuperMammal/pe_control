# Definition for stash server
class profiles::stashserver {
  include stash

  $stash_home = hiera('stash::homedir')

  File {
    owner  => 'stash',
    group  => 'stash',
    mode   => '0755',
  }

  class { 'postgresql::server' : }

  file { ['/opt/atlassian','/opt/atlassian/application-data',"$stash_home/external-hooks"] :
    ensure => 'directory',
  }

  postgresql::server::db { 'stash':
    user     => 'stash',
    password => hiera('stashdb_pass'),
  }

  file { "$stash_home/external-hooks/puppet_prereceive.sh":
    ensure => 'file',
    source => "puppet:///modules/${module_name}/puppet_prereceive.sh",
  }
}
