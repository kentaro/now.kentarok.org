package Kentarok::Now::App::Now;
use Mouse;
extends 'Kentarok::Now::App';

has 'user' => (
    is  => 'rw',
    isa => 'Maybe[HashRef]'
);

has 'twitter_url' => (
    is  => 'rw',
    isa => 'Maybe[Object]',
);

has 'error' => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

no Mouse;
__PACKAGE__->meta->make_immutable;

use Kentarok::Now::Model::Now;

sub entries {
    my ($self, $offset, $limit) = @_;
    my $model = Kentarok::Now::Model::Now->new;
       $model->retrieve(
           offset => $offset,
           limit  => $limit,
       );
}

sub create {
    my ($self, %args) = @_;

    return if !$self->user;

    # 超適当なのでちゃんとバリデーションしましょう
    if (!$args{now} || length $args{now} > 30) {
        $self->error(1);
        return;
    }
    else {
        my $model = Kentarok::Now::Model::Now->new;
           $model->create(%args);
    }

    1;
}

!!1;
