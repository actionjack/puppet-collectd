# Class collectd::mongodb
class collectd::mongodb (
  $is_enabled = 'true'
) {
  package {['libmongoc','pymongo']:
    ensure => 'installed',
  }
  File {
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    notify => Service['collectd5'],
  }
  file {'/opt/collectd-plugins/collectd-mongodb':
    ensure => 'directory',
    mode   => '0755',
  }
  file {'/opt/collectd-plugins/collectd-mongodb/mongodb.py':
    source  => 'puppet:///modules/collectd/opt/collectd-plugins/collectd-mongodb/mongodb.py',
    require => File['/opt/collectd-plugins/collectd-mongodb'],
  }
  file {'/opt/collectd-plugins/collectd-mongodb/types.db':
    source  => 'puppet:///modules/collectd/opt/collectd-plugins/collectd-mongodb/types.db',
    require => File['/opt/collectd-plugins/collectd-mongodb'],
  }
  file {'/etc/collectd5.d/mongodb.conf':
    content => template('collectd/plugins/mongodb.conf.erb'),
  }
}
