class profiles::crucibleserver (
  $crucibledb_pass
) {
  class {'postgresql::server' : }

  postgresql::server::db { 'crucible':
    user     => 'crucibledb',
    password => $crucibledb_pass,
  }
}
