class profiles::teamcityagent (
  $gemlist
) {
  Rvm_gem {
    ruby_version => 'ruby-2.0.0',
    ensure       => 'latest',
    require      => Rvm_system_ruby['ruby-2.0.0'],
  }

  rvm_gem { $gemlist: }
}
