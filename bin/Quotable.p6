#!/usr/bin/env perl6
# Copyright © 2016-2017
#     Aleks-Daniel Jakimenko-Aleksejev <alex.jakimenko@gmail.com>
# Copyright © 2016
#     Daniel Green <ddgreen@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use Whateverable;
use Misc;

use IRC::Client;

unit class Quotable does Whateverable;

my $CACHE-FILE = ‘data/irc/cache’.IO;

method help($msg) {
    “Like this: {$msg.server.current-nick}: /^ ‘bisect: ’ /”
}

multi method irc-to-me($msg where /^ \s* [ || ‘/’ $<regex>=[.*] ‘/’
                                           || $<regex>=[.*?]       ] \s* $/) {
    my $answer = perl6-grep($CACHE-FILE, ~$<regex>).join: “\n”;
    ‘’ but ProperStr($answer)
}

# ⚠ Quotable is currently broken. See issue #24
#exit 1;
Quotable.new.selfrun: ‘quotable6’, [ / quote6? <before ‘:’> /,
                                     fuzzy-nick(‘quotable6’, 2) ]

# vim: expandtab shiftwidth=4 ft=perl6
