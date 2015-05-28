# Base profile for Redhat systems
class profiles::base::redhat (
  $packages,
){
  #  include rvm
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

  #rvm_system_ruby {
  #  'ruby-2.0':
  #    ensure      => 'present',
  #    default_use => true,
  #}
}
