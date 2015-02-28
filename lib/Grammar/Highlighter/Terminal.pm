class Grammar::Highlighter::Terminal;

use Term::ANSIColor;

my @colors = < bold underline inverse black red green yellow blue magenta cyan white default on_black on_red on_green on_yellow on_blue on_magenta on_cyan on_white on_default >;

method colored(Str $code, Int $color) {
    return colored($code, @colors[$color % @colors.elems]);
}

# vim: ft=perl6
