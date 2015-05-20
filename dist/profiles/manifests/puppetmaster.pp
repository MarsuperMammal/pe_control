class profiles::puppetmaster {
  include pw_puppet::activemq
  include pw_puppet::console
  include pw_puppet::master::ca
  include pw_puppet::master::compile
}
