package Dotcloud::Kentaro;
use Dancer ':syntax';
use Dancer::Plugin::Auth::Twitter;

our $VERSION = '0.01';

use Dotcloud::Kentaro::App::Now;

auth_twitter_init;

get '/' => sub {
    my $app = Dotcloud::Kentaro::App::Now->new(
        user        => session('twitter_user'),
        twitter_url => !session('twitter_user') ? auth_twitter_authenticate_url : undef,
    );

    template 'index', { app => $app };
};

post '/' => sub {
    my $app = Dotcloud::Kentaro::App::Now->new(
        user => session('twitter_user'),
    );

    if ($app->create(
        now  => params->{now},
        user => session('twitter_user'),
    )) {
        redirect '/';
    }
    else {
        template 'index', { app => $app };
    }
};

true;
