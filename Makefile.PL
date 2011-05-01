use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Kentarok::Now',
    AUTHOR       => 'Kentaro Kuribayashi',
    VERSION_FROM => 'lib/Kentarok/Now.pm',

    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'MIT')
      : ()),

    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'                    => 0.96,
        'YAML'                          => 0,
        'JSON::XS'                      => 2.3,
        'UNIVERSAL::require'            => 0,
        'Template'                      => 0,
        'Dancer'                        => 1.3030,
        'Dancer::Session::Cookie'       => 0,
        'Dancer::Plugin::Auth::Twitter' => 0,
        'LWP::Protocol::https'          => 6.02,
        'Plack::Request'                => 0,
        'Mouse'                         => 0.92,
        'Redis'                         => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Dotcloud-Kentaro-*' },
);
