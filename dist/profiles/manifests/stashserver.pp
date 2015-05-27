# Definition for stash server
class profiles::stashserver {
  include stash

  File {
    owner  => 'stash',
    group  => 'stash',
    mode   => '0755',
  }

  class { 'postgresql::server' : }

  file { ['/opt/atlassian','/opt/atlassian/application-data','/external-hooks'] :
    ensure => 'directory',
  }

  postgresql::server::db { 'stash':
    user     => 'stash',
    password => hiera('stashdb_pass'),
  }

  file { '/external-hooks/puppet_prereceive.sh':
    ensure => 'file',
    source => "puppet:///${module_name}/puppet_prereceive.sh",
  }
}
