# == Class: collectd
#
# Full description of class collectd here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { collectd:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class collectd (
  $graphite_host = 'graphite',
  $graphite_port = '2003'
) inherits collectd::params {
  package { 'collectd5':
    ensure => 'latest',
  }
  service { 'collectd5':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
  File {
    owner  => 'root',
    group  => 'root',
    notify => Service['collectd5'],
  }
  file {'/etc/collectd5.d':
    ensure => 'directory',
    mode   => '0755',
  }
  file {'/etc/sysconfig/collectd5':
    content => template('collectd/collectd5.erb'),
    mode    => '0644',
  }
  file {'/etc/collectd5.conf':
    content => template('collectd/collectd5.conf.erb'),
    mode    => '0644',
  }
  file {'/etc/collectd5.d/graphite.conf':
    content => template('collectd/plugins/graphite.conf.erb'),
    mode    => '0644',
  }
}
