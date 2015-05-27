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

  file { ['/opt/atlassian','/opt/atlassian/application-data',"${stash_home}/external-hooks"] :
    ensure => 'directory',
  }

  postgresql::server::db { 'stash':
    user     => 'stash',
    password => hiera('stashdb_pass'),
  }

  vcs_repo { "${stash_home}/external-hooks" :
    ensure   => 'latest',
    provider => 'git',
    source   => 'http://stash.pwatts.net:7990/mtp/pw_hooks.git',
    revision => 'stable',
  }
}
