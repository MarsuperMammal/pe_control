# Base Monolith profile
class profiles::puppetmaster {
  include pw_puppet::activemq
  include pw_puppet::master::ca
  include pw_puppet::master::compile
}
