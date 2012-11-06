# Class collectd::java
class collectd::java (
  $jmx_monitor_user     = 'jmxmonitoruser',
  $jmx_monitor_password = 'jmxpassword'
) {
  package { ['collectd5-java', 'java-1.7.0-openjdk-devel']:
    ensure => 'installed',
  }
  file {'/etc/collectd5.d/java.conf':
    content => template['collectd/java.conf.erb'],
    notify  => Service['collectd5'],
  }
}
