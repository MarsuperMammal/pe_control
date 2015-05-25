class profiles::base {
  case $::osfamily {
    'redhat' : {
      include profiles::base::redhat
    }
    default : {
    }
  }

  class { 'sudo' : }
  sudo::conf {'aharden' :
    ensure   => 'present',
    priority => '11',
    content  => 'pwatts ALL=(ALL) NOPASSWD: ALL'
  }
  sudo::conf {'pwatts' :
    ensure   => 'present',
    priority => '10',
    content  => 'pwatts ALL=(ALL) NOPASSWD: ALL'
  }
  group { 'pwatts':
    ensure => 'present',
  }->
  user { 'pwatts':
    ensure         => 'present',
    groups         => 'pwatts',
    home           => '/home/pwatts',
    shell          => '/bin/zsh',
    purge_ssh_keys => true,
  }->
  file { '/home/pwatts':
    ensure => 'directory',
    owner  => 'pwatts',
    group  => 'pwatts',
    mode   => '0700',
  }->
  file { '/home/pwatts/.ssh':
    ensure => 'directory',
    owner  => 'pwatts',
    group  => 'pwatts',
    mode   => '0600',
  }->
  ssh_authorized_key { 'pwatts217@gmail.com':
    user => 'pwatts',
    type => 'ssh-rsa',
    key  => hiera('pwatts_id_rsa'),

  }

  group {'aharden':
    ensure => 'present',
  }->
  user { 'aharden':
    ensure         => 'present',
    groups         => 'aharden',
    home           => '/home/aharden',
    shell          => '/bin/zsh',
    purge_ssh_keys => true,
  }->
  file { '/home/aharden/':
    ensure => 'directory',
    owner  => 'aharden',
    group  => 'aharden',
    mode   => '0700',
  }->
  file { '/home/aharden/.ssh':
    ensure => 'directory',
    owner  => 'aharden',
    group  => 'aharden',
    mode   => '0600',
  }->
  ssh_authorized_key { 'aharden@te.com':
    user => 'aharden',
    type => 'ssh-rsa',
    key  => hiera('aharden_id_rsa'),
  }
}
