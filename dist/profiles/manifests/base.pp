class profiles::base {
  case $::osfamily {
    'redhat' : {
      include profiles::base::redhat
    }
    default : {
    }
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
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDYW7nMpUo/aFq1+Ch5u1iv/vZJ73ymF61JJ3IL/Km6TC2gZy5wCQjT9eQkgcPmDDva+clIMgbMiVEA0HRr+DUisXZcedvS+xcx89zplNiPjPlSNJS6nUh6Ui35whM8betjpo9NwfILnSyvp+wueHQzEie/blxq9FgXvUXV7MoLsUkATiLruhoNHO0jYdJ1pmNLvm9p21ePdF08jbEfD691ohTGHSjRZmyCdHjfkYTTrrP9ay/6htxsPuO+9SFPfHPiSAGDByghrcV7JAZWNCFRai5dBTCTPlB+ChlDKDy4HZ2umtguUWuvpRo04rAtoB07kYy3/Z1Joog6aQgzWPEz',
  }

  group {'aharden':
    ensure => 'present',
  }->
  user { 'aharden':
    ensure => 'present',
    groups => 'aharden',
    home   => '/home/aharden',
    shell  => '/bin/zsh',
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
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDTuLisAYwu72OAfh1/SxvqZgEQ2IW3/3nlBm4LMIPRpVg2tRFCZ5UwmaL8+VW4mNs/tlXLkyYA+lDVe4jJcbzvQ8ZC1d2pK/gwN7JGjle/Ui4UzBpFT19AMrMQ6KCOGOgqwunQuzMTtth89QxCYFvNwIuchU5uB4V7rvX2KOyCrPlxIt1fxYBObyhS6eiW322GiOX/3Boo43DwMSIGBlTfBAsolHypZtJcEN0hQonKifB51Y7+s6WwQtd19P6Fxn1kg9aUo5JxRW4IWNKnuQ/KB6HdmyWx5mE3MyC826Zgv0q3jVWYLw2txaVFM9KgoZ5kmwe593cK2Hev9CSuV1iD',
  }
}
