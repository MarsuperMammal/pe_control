# Implementation class for monolithic Puppet Master
class roles::puppetmaster {
  include profiles::puppetmaster
  include profiles::r10k_webhook
}
