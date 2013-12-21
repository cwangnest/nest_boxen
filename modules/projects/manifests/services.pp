class projects::services { 
  include nodejs::v0_10

  include python
  include sequel_pro

  package {
   [
     'nginx',
     'npm',
     'md5deep',
   ]:
  }	

  exec { "npm install -g less@1.3.0":
    command => "npm install -g less@1.3.0",
    require => Package['npm'],
    logoutput => true
  }

  exec { "npm install -g orderly@1.3.0":
    command => "npm install -g orderly@1.0.1",
    require => Package['npm'],
    logoutput => true
  }

  # Setup local interface addresses 
  exec { "Setup local interface addresses":
    user => root,
    command => "sudo ifconfig lo0 add 127.94.0.9; sudo ifconfig lo0 add 127.94.0.10;\
                sudo ifconfig lo0 add 127.94.0.11; sudo ifconfig lo0 add 127.94.0.19;",	
    logoutput => true
  }

  
}