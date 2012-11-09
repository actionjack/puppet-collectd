# Class collectd::disk
class collectd::disk (
  $diskdrives     = $::diskdrives
) {
  file {'/etc/collectd5.d/disk.conf':
    content => template('collectd/plugins/disk.conf.erb'),
    notify  => Service['collectd5'],
  }
}
