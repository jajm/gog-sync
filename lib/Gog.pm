package Gog;

use Modern::Perl;

use utf8;
use open ':encoding(utf8)', ':std';

use LWP::UserAgent;
use JSON;
use HTTP::Request;

sub new {
    my ($class, $config) = @_;

    $config //= {};
    $config->{languages} //= ['English'];
    $config->{os} //= ['windows'];
    $config->{extras} //= 0;

    my $self = {
        config => $config,
    };

    return bless $self, $class;
}

sub request {
    my ($self, $url) = @_;

    my $ua = LWP::UserAgent->new();
    $ua->max_redirect(0);

    my $req = HTTP::Request->new(GET => $url);
    $req->header(Cookie => 'gog-al=' . $self->{config}->{gog_al});

    return $ua->request($req);
}

sub json_request {
    my ($self, $url) = @_;

    my $res = $self->request($url);
    my $json;
    eval {
        $json = from_json($res->decoded_content);
        return $json;
    };
    if ($@) {
        warn "Error requesting $url : $@";
    }

    return $json;
}

sub games {
    my ($self) = @_;

    return $self->json_request('https://www.gog.com/user/data/games');
}

sub game {
    my ($self, $id) = @_;

    return $self->json_request("https://www.gog.com/account/gameDetails/$id.json");
}

1;
