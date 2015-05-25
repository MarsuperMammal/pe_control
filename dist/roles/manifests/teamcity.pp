# Implementation class for Teamcity CI
class roles::teamcity {
  include profiles::teamcityserver
  include profiles::teamcityagent
}
