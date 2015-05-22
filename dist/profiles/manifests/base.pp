class profiles::base {
  case $::osfamily {
    'redhat' : {
      include profiles::base::redhat
    }
    default : {
    }
  }

  user { 'pwatts':
    ensure         => 'present',
    groups         => 'pwatts',
    home           => '/home/pwatts',
    shell          => '/bin/zsh',
    purge_ssh_keys => true,
  }->
  ssh_authorized_key { 'pwatts217@gmail.com':
    user => 'pwatts',
    type => 'ssh-rsa',
    key  => $pwatts_id_rsa,
  }

  user { 'aharden':
    ensure => 'present',
    groups => 'aharden',
    home   => '/home/aharden',
    shell  => '/bin/zsh',
    purge_ssh_keys => true,
  }->
  ssh_authorized_key { 'aharden@te.com':
    user => 'aharden',
    type => 'ssh-rsa',
    key  => $aharden_id_rsa,
  }
}
