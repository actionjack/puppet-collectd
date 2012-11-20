# Class collectd::haproxy
class collectd::haproxy (
  $is_enabled = 'true'
) {
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['collectd5'],
  }
  file {'/opt/collectd-plugins/collectd-haproxy':
    ensure => 'directory',
    mode   => '0755',
  }
  file {'/opt/collectd-plugins/collectd-haproxy/haproxy.py':
    source  => 'puppet:///modules/collectd/opt/collectd-plugins/collectd-haproxy/haproxy.py',
    require => File['/opt/collectd-plugins/collectd-haproxy'],
  }
  file {'/etc/collectd5.d/haproxy.conf':
    content => template('collectd/plugins/haproxy.conf.erb'),
  }
}
