class profiles::jiraserver (
  $jiradb_pass
) {
  include jira

  class {'postgresql::server': }

  postgresql::server::db { 'jira':
    user     => 'jiraadm',
    password => $jiradb_pass,
  }
}
