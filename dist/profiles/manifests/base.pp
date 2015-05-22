class profiles::base {
  case $::osfamily {
    'redhat' : {
      include profiles::base::redhat
    }
    default : {
    }
  }
}
