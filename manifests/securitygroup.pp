class tse_awsnodes::securitygroup (
  region = $::ec2_region,
) {

  ec2_securitygroup { 'tse-master':
    ensure      => present,
    region      => $region,
    vpc         => 'tse-vpc',
    description => 'Security group for use by the Master, and associated ports',
    ingress     => [
      {
        protocol => 'tcp',
        port     => '80',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '22',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '443',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '3000',
        cidr     => '0.0.0.0/0',
      },
      {
        cidr => '10.0.0.0/16', 
        port => '-1', 
        protocol => 'icmp'
      },
      {
        security_group => 'tse-agents',
      },
    ],
    tags           => {
      'Department' => 'TSE',
      'Project'    => 'Infrastructure',
      'created_by' => 'cbarker',
    }
  }

  ec2_securitygroup { 'tse-agents':
    ensure      => present,
    region      => $region,
    vpc         => 'tse-vpc',
    description => 'Security group for use by the agents - allows their port access to master also',
    ingress     => [
      {
        protocol => 'tcp',
        port     => '80',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '22',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '443',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '3389',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '8080',
        cidr     => '0.0.0.0/0',
      },
      {
        protocol => 'tcp',
        port     => '8000',
        cidr     => '0.0.0.0/0',
      },
      {
        cidr => '10.0.0.0/16', 
        port => '-1', 
        protocol => 'icmp'
      },
      {
        security_group => 'tse-master',
      },
      {
        security_group => 'tse-agents',
      },
    ],
    tags           => {
      'Department' => 'TSE',
      'Project'    => 'Infrastructure',
      'created_by' => 'cbarker',
    }
  }
}
