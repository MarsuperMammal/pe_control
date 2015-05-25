# Bamboo CI tool from Atlassian, because I'm lazy
class profiles::bambooserver {
  class { '::bamboo':
    username    => 'bamboo',
    pass_hash   => hiera('bamboo_pass'),
    bamboo_home => '/home/bamboo',
    bamboo_data => '/opt/bamboo',
    java_manage => false,
    db_manage   => true,
    db_name     => 'bamboo_db',
    db_pass     => hiera('bamboodb_pass'),
  }
}
