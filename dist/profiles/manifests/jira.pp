class profiles::jira (
  $jiradb_pass
) {
  include jira

  class {'postgres::server': }

  postgres::server::db { 'jira':
    user     => 'jiraadm',
    password => $jiradb_pass,
  }
 
  group { 'jira':
    ensure => 'present',
  }

  user { 'jira':
    ensure => 'present',
    groups => 'jira',
  }

}
