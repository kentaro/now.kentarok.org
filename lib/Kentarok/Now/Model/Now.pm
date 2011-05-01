package Kentarok::Now::Model::Now;
use Mouse;
with qw(Kentarok::Now::Model);

use UNIVERSAL::require;

has 'table' => (
    is      => 'rw',
    isa     => 'Str',
    default => 'now',
);

has 'storage' => (
    is      => 'rw',
    default => sub {
        Kentarok::Now::Storage::Redis->use;
        Kentarok::Now::Storage::Redis->new;
    },
    lazy => 1,
);

no Mouse;
__PACKAGE__->meta->make_immutable;

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
