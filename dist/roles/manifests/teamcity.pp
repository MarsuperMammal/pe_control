class roles::teamcity {
  include profiles::teamcityserver

  postgresql::server::db { 'teamcity':
    user     => 'teamcitydb',
    password => $teamcitydb_pass,
  }
}
