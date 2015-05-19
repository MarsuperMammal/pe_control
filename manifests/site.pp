## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Define filebucket 'main':
filebucket { 'main':
  server => $::settings::archive_file_server,
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

# Global Resource Declarations:
Package { tag =>  'provisioner', }

# Configuration for proxy server in language specific package providers
#Package <| (provider == 'pe_gem' or provider == 'gem') |> {
#  install_options  +> [
#    { '--http-proxy' => 'http://proxy.domain.net:80' }
#  ]
#}
#Package <| provider == 'pip' |> {
#  install_options +> [
#    { '--proxy' => 'http://proxydirect.tycoelectronics.com:80' }
#  ]
#}

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}
