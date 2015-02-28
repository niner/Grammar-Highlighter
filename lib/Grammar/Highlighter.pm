class Grammar::Highlighter;
use Term::ANSIColor;

my @colors = < bold underline inverse black red green yellow blue magenta cyan white default on_black on_red on_green on_yellow on_blue on_magenta on_cyan on_white on_default >;

class Highlighted {
    has Str $.orig;
    has Int $.from;
    has Int $.to;
    has @.children;
    has $.color;

    method Str() {
        if @.children {
            my $first-sub = @.children>>.from.min - $.from;
            my $last-sub  = @.children>>.to.max;
            my $children  = @.children>>.Str.join('');
            if $first-sub > 0 or $last-sub > 0 {
                return colored(
                    $.orig.substr($.from, $first-sub)
                        ~ $children
                        ~ $.orig.substr($last-sub, $.to - $last-sub),
                    @colors[$.color]
                );
            }
            else {
                return $children;
            }
        }
        else {
            return colored(
                $.orig.substr($.from, $.to - $.from),
                @colors[$.color]
            );
        }
    }
}

my $current = 0;
my %known;
::?CLASS.HOW.add_fallback(::?CLASS, -> $, $ { True },
    method ($name) {
        -> \self, $/ {
            if $name eq 'ws' {
                make $/;
            }
            else {
                make Highlighted.new(
                    orig => $/.orig,
                    from => $/.from,
                    to => $/.to,
                    children => $/.hash.values.map({$_ ~~ Positional ?? $_>>.ast !! $_.ast}),
                    color => %known{$name} //= $current++,
                );
            }
        }
    }
);

# vim: ft=perl6
