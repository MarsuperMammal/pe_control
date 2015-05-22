class profiles::stashserver (
  $stashdb_pass
) {
  include stash

  class { 'postgresql::server' : }

  file { ['/opt/atlassian','/opt/atlassian/application-data/'] :
    ensure => 'directory',
    owner  => 'stash',
    group  => 'stash',
    mode   => '0755',
  }

  postgresql::server::db { 'stash':
    user     => 'stash',
    password => $stashdb_pass,
  }
}
