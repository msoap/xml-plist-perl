use 5.10.0;

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
    NAME              => 'XML::PList',
    VERSION_FROM      => 'lib/XML/PList.pm',
    PREREQ_PM         => {
        'XML::LibXML' => 
    },
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/XML/PList.pm', # retrieve abstract from module
       AUTHOR         => 'Sergey Mudrik <sergey.mudrik@gmail.com>')
      : ()
    ),
);
