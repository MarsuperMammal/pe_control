class profiles::base::redhat (
  $packages,
){
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

  class { '::rvm': }

  rvm_system_ruby {
    'ruby-2.0-p645':
      ensure      => 'present',
      default_use => true,
  }
}
