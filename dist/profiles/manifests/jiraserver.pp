class profiles::jiraserver (
  $jiradb_pass
) {
  include jira

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
