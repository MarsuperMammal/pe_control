class profiles::crucibleserver {
  class {'postgresql::server' : }

  postgresql::server::db { 'crucible':
    user     => 'crucibledb',
    password => hiera('crucibledb_pass'),
  }
}
