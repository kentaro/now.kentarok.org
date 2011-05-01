package Dotcloud::Kentaro::Model::Now;
use Mouse;
with qw(Dotcloud::Kentaro::Model);

has 'table' => (
    is      => 'rw',
    isa     => 'Str',
    default => 'now',
);

has 'storage' => (
    is      => 'rw',
    default => sub {
        Dotcloud::Kentaro::Storage::Redis->use;
        Dotcloud::Kentaro::Storage::Redis->new;
    },
    lazy => 1,
);

no Mouse;
__PACKAGE__->meta->make_immutable;

use UNIVERSAL::require;

sub create {
    my ($self, %args) = @_;
    $self->storage->create(table => $self->table, %args);
}

sub retrieve {
    my ($self, %args) = @_;
    $self->storage->retrieve(table => $self->table, %args);
}

sub update {}

sub delete {}

!!1;
