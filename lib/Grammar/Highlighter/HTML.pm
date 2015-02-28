class Grammar::Highlighter::HTML;

use Term::ANSIColor;

my @colors = < aqua blue fuchsia gray green lime maroon navy olive purple red silver teal white yellow >;

method colored(Str $code, Int $color) {
    return qq!<span style="color: {@colors[$color % @colors.elems]};">{$code}</span>!;
}

# vim: ft=perl6

