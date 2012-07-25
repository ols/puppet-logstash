# Class: puppet-logstash
#   w/ help from http://imcol.in/2012/05/deploying-logstash-with-puppet/
#
# This module manages puppet-logstash
#
# Parameters:
#
# Actions:
#
# Requires:
#  That you've run ./download.sh to download the jar into the files directory.
# Sample Usage:
#  class { 'logstash': }
class logstash($version = '1.1.1') {

  file { "/opt/logstash-${version}-monolithic.jar":
    source => "puppet:///modules/logstash/logstash-${version}-monolithic.jar",
    ensure => present
  }
  
  file { '/etc/logstash.conf':
    content => template('logstash/amqp.indexer.conf.erb'),
    ensure => present,
    replace => false
  }
  
  file {"/etc/init/logstash.conf":
    source => "puppet:///logstash/files/logstash.conf",
    ensure => present,
    mode => 0644,
    owner => root,
    group => root
  }
  
  file { '/etc/init.d/logstash':
    ensure => 'link',
    target => '/lib/init/upstart-job',
    owner => 'root',
    group => 'root'
  }
  
  service {"logstash":
    ensure => running,
    subscribe => [
      File['/etc/logstash.conf'],
      File['/etc/init.d/logstash']
    ],
    require => [
      File["/etc/init/logstash.conf"],
      File["/etc/logstash.conf"],
      File["/opt/logstash-${version}-monolithic.jar"]
    ],
    provider => "upstart"
  }
}
