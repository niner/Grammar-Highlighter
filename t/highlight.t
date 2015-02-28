use Test;

use Grammar::Highlighter;
use Grammar::Highlighter::Terminal;

grammar Foo {
    rule TOP {
        <directive>+
    }
    rule directive {
        [
            <foo>
            | <bar>
        ]
        ';'
    }
    rule foo {
        Foo <baz>
    }
    rule bar {
        Bar <baz>
    }
    token baz {
        Baz
    }
}

my $parser = Foo.new;
my $highlighter = Grammar::Highlighter.new(:formatter(Grammar::Highlighter::Terminal.new));

is($parser.parse(q:heredoc/INPUT/, :actions($highlighter)).ast.Str, qq:heredoc/OUTPUT/.chomp);
    Foo Baz;
    Foo Baz;
    Bar Baz;
    INPUT
    \x[1b][31m\x[1b][7m\x[1b][4mFoo \x[1b][1mBaz\x[1b][0m\x[1b][0m;
    \x[1b][0m\x[1b][7m\x[1b][4mFoo \x[1b][1mBaz\x[1b][0m\x[1b][0m;
    \x[1b][0m\x[1b][7m\x[1b][30mBar \x[1b][1mBaz\x[1b][0m\x[1b][0m;
    \x[1b][0m\x[1b][0m
    OUTPUT

done;

# vim: ft=perl6
