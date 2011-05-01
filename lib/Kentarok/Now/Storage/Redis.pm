package Kentarok::Now::Storage::Redis;
use Mouse;
with qw(Kentarok::Now::Storage);

no Mouse;
__PACKAGE__->meta->make_immutable;

use Redis;
use JSON::XS ();
use Dancer ':syntax';

sub redis {
    # ここでおもむろにDancerのconfig使うのよくないのでちゃんとするべき
    my $redis = Redis->new(%{config->{redis}});

    if (config->{redis}{password}) {
        $redis->auth(config->{redis}{password});
    }

    $redis;
}

sub create {
    my ($self, %args) = @_;
    my $table = delete $args{table};
    redis->lpush($table, JSON::XS::encode_json(\%args));
}

sub retrieve {
    my ($self, %args) = @_;
    my $table  = delete $args{table};
    my $offset = delete $args{offset} || 0;
    my $limit  = delete $args{limit} ? ($args{offset} + $args{limit}) - 1
                              : $args{offset};

    +[ map { JSON::XS::decode_json($_) } redis->lrange($table, $offset, $limit) ];
}

sub update {}

sub delete {}

!!1;
