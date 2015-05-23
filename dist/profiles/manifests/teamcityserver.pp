class profiles::teamcityserver (
  $teamcitydb_pass
  ) {
  class {'postgresql::server': }

  postgresql::server::db { 'teamcity':
    user     => 'teamcitydb',
    password => $teamcitydb_pass,
  }
}
