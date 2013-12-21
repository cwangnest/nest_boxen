class projects::potion {
   # Make sure python 2.7.5 is installed
   include python

   file { "/Users/${::boxen_user}/Code":
     ensure => "directory"
  }

   # Get repo
   repository {
     "/Users/${::boxen_user}/Code/potion":
     source => "git@github.com:nestlabs/potion.git",
     provider => "git",
     ensure => present
   }
 
   # Set up a virtualenv 
   
   python::mkvirtualenv { 'potion':
     systempkgs => false,
     distribute => true,
     project_dir => "/Users/${::boxen_user}/Code/potion"
   }
   ->
   notify { 'after' : 
     message => 'potion virtualenv created', 
   }

   # install requirements.
   python::requirements { "potion requirements":
     requirements => "/Users/${::boxen_user}/Code/potion/requirements.txt",
     virtualenv   => "potion",
     subscribe => Notify['after']
   }   
}
