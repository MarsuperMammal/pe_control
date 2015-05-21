# Base profile for an Arbiter
class profiles::arbiter {
  include aws
  package { ['aws-sdk-core','retries']:
    ensure   => 'installed',
    provider => 'pe-gem',
  }
}
