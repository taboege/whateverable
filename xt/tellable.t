#!/usr/bin/env perl6
BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
%*ENV<TESTABLE> = 1;

use lib <lib xt/lib>;
use Test;
use Testable;

my $t = Testable.new: bot => ‘Tellable’;

$t.common-tests: help => ‘Like this: .tell AlexDaniel your bot is broken’;

$t.shortcut-tests: < to: tell: ask: seen:>,
                   < to, tell, ask, seen,>;

$t.test(‘fallback’,
        “{$t.bot-nick}: wazzup?”,
        “{$t.our-nick}, I cannot recognize this command. See wiki for some examples: https://github.com/perl6/whateverable/wiki/Tellable”);


$t.test(‘send a message’,
        “hello world”,);

# Seen

$t.test(‘.seen’,
        “.seen {$t.our-nick}”,
        /^ <me($t)>‘, I saw ’<me($t)>‘ 2’\S+‘Z in #whateverable_tellable6: <’<me($t)>‘> hello world’ $/
       );

$t.test(‘seen:’,
        “seen: {$t.our-nick}”,
        /^ <me($t)>‘, I saw ’<me($t)>‘ 2’\S+‘Z in #whateverable_tellable6: <’<me($t)>‘> hello world’ $/
       );

$t.test(‘seen without seen’,
        “{$t.bot-nick}: {$t.our-nick}”,
        /^ <me($t)>‘, I saw ’<me($t)>‘ 2’\S+‘Z in #whateverable_tellable6: <’<me($t)>‘> hello world’ $/
       );

$t.test(‘unnecessary seen’,
        “{$t.bot-nick}: seen {$t.our-nick}”,
        /^ <me($t)>‘, I saw ’<me($t)>‘ 2’\S+‘Z in #whateverable_tellable6: <’<me($t)>‘> hello world’ $/
       );

$t.test(‘no such nickname (seen)’,
        ‘.seen nobody’,
        “{$t.our-nick}, I haven't seen nobody around”);

# TODO it kinda works but for some reason not with long nicks
#$t.test(‘.seen autocorrect’,
#        “.seen x{$t.our-nick}”,
#        “{$t.our-nick}, I haven't seen x{$t.our-nick} around, did you mean {$t.our-nick}?”);


# Tell

$t.test(‘.tell’,
        ‘.tell nobody foo’,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘.to’,
        ‘.to nobody foo’,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘.ask’,
        ‘.ask nobody foo’,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘tell:’,
        ‘tell: nobody foo’,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘to:’,
        ‘to: nobody foo’,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘ask:’,
        ‘ask: nobody foo’,
        “{$t.our-nick}, I haven't seen nobody around”);


$t.test(‘tell without tell’,
        “{$t.bot-nick}: nobody foo”,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘unnecessary tell’,
        “{$t.bot-nick}: tell nobody foo”,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘unnecessary to’,
        “{$t.bot-nick}: to nobody foo”,
        “{$t.our-nick}, I haven't seen nobody around”);

$t.test(‘unnecessary ask’,
        “{$t.bot-nick}: ask nobody foo”,
        “{$t.our-nick}, I haven't seen nobody around”);


$t.test(‘passing a message works’,
        “.tell {$t.our-nick} secret message”,
        “{$t.our-nick}, I'll pass your message to {$t.our-nick}”);

$t.test(‘message delivery works’,
        ‘I'm back!’,
        /^ ‘2’\S+‘Z #whateverable_tellable6 <’<me($t)>‘> ’<me($t)>‘ secret message’ $/
       );

$t.test(‘passing multiple messages (1)’,
        “.tell {$t.our-nick} secret message one”,
        “{$t.our-nick}, I'll pass your message to {$t.our-nick}”);

$t.test(‘passing multiple messages (2)’,
        “.tell {$t.our-nick} secret message two”,
        “{$t.our-nick}, I'll pass your message to {$t.our-nick}”);

$t.test(‘receiving multiple messages’,
        ‘I'm back!’,
        /^ ‘2’\S+‘Z #whateverable_tellable6 <’<me($t)>‘> ’<me($t)>‘ secret message one’ $/,
        /^ ‘2’\S+‘Z #whateverable_tellable6 <’<me($t)>‘> ’<me($t)>‘ secret message two’ $/,
       );


$t.test(‘passing messages to the bot itself’,
        “.tell {$t.bot-nick} I love you”,
        “{$t.our-nick}, Thanks for the message”);


# TODO it kinda works but for some reason not with long nicks
#$t.test(‘.tell autocorrect’,
#        “.tell x{$t.our-nick} hello”,
#        “{$t.our-nick}, I haven't seen x{$t.our-nick} around, did you mean {$t.our-nick}?”);


$t.last-test;
done-testing;
END $t.end;

# vim: expandtab shiftwidth=4 ft=perl6
