class roles::pw_puppetmaster {
  include profiles::puppetmaster
  include profiles::r10k_webhook
}
