package App::ANSIColorUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{show_ansi_color_table} = {
    v => 1.1,
    summary => 'Show a table of ANSI codes & colors',
    args => {
        width => {
            schema => ['str*', in=>[8, 16, 256]],
            default => 8,
            cmdline_aliases => {
                8   => {is_flag=>1, summary => 'Shortcut for --width=8'  , code => sub { $_[0]{width} = 8 }},
                16  => {is_flag=>1, summary => 'Shortcut for --width=16' , code => sub { $_[0]{width} = 16 }},
                256 => {is_flag=>1, summary => 'Shortcut for --width=256', code => sub { $_[0]{width} = 256 }},
            },
        },
    },
};
sub show_ansi_color_table {
    require Color::ANSI::Util;

    my %args = @_;

    my $width = $args{width};

    my @rows;
    for (0 .. $width - 1) {
        push @rows, {
            code => $_,
            color=>
                $_ < 8   ? sprintf("\e[%dm%s\e[0m", 30+$_, "This is ANSI color #$_") :
                $_ < 16  ? sprintf("\e[1;%dm%s\e[0m", 30+$_-8, "This is ANSI color #$_") :
                           sprintf("\e[38;5;%dm%s\e[0m", $_, "This is ANSI color #$_"),
        };
    }
    [200, "OK", \@rows];
}

1;
#ABSTRACT: Utilities related to ANSI color

=head1 DESCRIPTION

This distributions provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

=cut
