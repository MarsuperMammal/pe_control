case profiles::base::redhat (
  $packages
) {
  package { $packages:
    ensure => 'installed',
  }
  class { 'selinux':
    mode => 'disabled'
  }
  service { 'iptables':
    ensure => 'stopped',
    enable => false,
  }
}
