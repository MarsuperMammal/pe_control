# Definition for stash server
class profiles::stashserver {
  include stash

  $stash_home = hiera('stash::homedir')
  $hookdir = "${stash_home}/external_hooks/commit_hooks"
  File {
    owner  => 'stash',
    group  => 'stash',
    mode   => '0755',
  }

  class { 'postgresql::server' : }

  file { ['/opt/atlassian',
          '/opt/atlassian/application-data',
          "${stash_home}/external_hooks",
          $hookdir,
          "${hookdir}/commit_hooks",
          ] :
    ensure => 'directory',
  }

  postgresql::server::db { 'stash':
    user     => 'stash',
    password => hiera('stashdb_pass'),
  }

  file { "${hookdir}/puppet_prereceive.sh" :
    ensure  => file,
    content => template("${module_name}/puppet_prereceive.erb"),
  }

  file { "${hookdir}/commit_hooks/puppet_lint_checks.sh" :
    ensure => 'file',
    source => "puppet:///modules/${module_name}/puppet_lint_checks.sh",
  }

  file { "${hookdir}/commit_hooks/puppet_manifest_syntax_checks.sh" :
    ensure => 'file',
    source => "puppet:///modules/${module_name}/puppet_manifest_syntax_checks.sh",
  }
}
