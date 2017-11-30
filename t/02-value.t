use v6;

use Test;
use Test::When <extended>;

use DB::Pg;

plan 13;

my $pg = DB::Pg.new;

is $pg.query('select 42').value, 42, 'value int';

is $pg.query('select $1::int', 42).value, 42, 'value int placeholder';

is $pg.query("select 'this'").value, 'this', 'value string';

is $pg.query('select $1::text', 'this').value, 'this',
    'value string placeholder';

is $pg.query("select 42e43").value, 42e43, 'value float';

is $pg.query('select $1::float8',42e43).value, 42e43, 'value float placeholder';

my $buf = Buf.new(1,2,3,4);

is $pg.query('select $1::bytea', $buf).value, $buf, 'value bytea placeholder';

is $pg.query("select 't'::bool").value, True, 'value bool';

is $pg.query('select $1::bool', False).value, False, 'value bool placeholder';

is $pg.query('select null').value, Any, 'Null';

is $pg.query('select $1::text', Str).value, Str, 'Null String placeholder';

is $pg.query("select '2000-01-01'::date").value, Date.new(2000,1,1), 'Date';

is $pg.query("select '2000-01-01'::timestamp").value,
    DateTime.new(2000,1,1,0,0,0), 'DateTime';

done-testing;
