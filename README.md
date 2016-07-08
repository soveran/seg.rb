Seg
===

Segment matcher for paths.

Description
-----------

Seg provides two methods for consuming and capturing path segments.
A path is a string that starts with a slash and contains segments
separated by slashes, for example `/foo/bar/baz` or `/users/42`.

Usage
-----

Consider this interactive session:

```ruby
>> s = Seg.new("/users/42")
=> #<Seg ...>

>> s.prev
=> ""

>> s.curr
=> "/users/42"

>> s.consume("users")
=> true

>> s.prev
=> "/users"

>> s.curr
=> "/42"

>> s.consume("42")
=> true

>> s.prev
=> "/users/42"

>> s.curr
=> ""
```

The previous example shows how to walk the path by
providing segments to consume. In the following
example, we'll see what happens when we try to
consume a segment with a string that doesn't match:

```ruby
>> s = Seg.new("/users/42")
=> #<Seg ...>

>> s.prev
=> ""

>> s.curr
=> "/users/42"

>> s.consume("admin")
=> false

>> s.prev
=> ""

>> s.curr
=> "/users/42"
```

As you can see, the command fails and the `prev` and
`curr` strings are not altered. Now we'll see
how to capture segment values:

```ruby
>> s = Seg.new("/users/42")
=> #<Seg ...>

>> captures = {}
=> {}

>> s.prev
=> ""

>> s.curr
=> "/users/42"

>> s.capture(:foo, captures)
=> true

>> s.prev
=> "/users"

>> s.curr
=> "/42"

>> s.capture(:bar, captures)
=> true

>> s.prev
=> "/users/42"

>> s.curr
=> ""

>> captures
=> {:foo=>"users", :bar=>42}
```

It is also possible to `extract` the next segment from the path.
The method `extract` returns the next segment, if available, or nil
otherwise:

```ruby
>> s = Seg.new("/users/42")
=> #<Seg ...>

>> s.prev
=> ""

>> s.curr
=> "/users/42"

>> s.extract
=> "users"

>> s.prev
=> "/users"

>> s.curr
=> "/42"

>> s.extract
=> "42"

>> s.prev
=> "/users/42"

>> s.curr
=> ""
```

You can also go back by using the methods `retract` and `restore`,
which are the antidote to `extract` and `consume` respectively.

Let's see how `retract` works:

```ruby
>> s = Seg.new("/users/42")
=> #<Seg ...>

>> s.prev
=> ""

>> s.curr
=> "/users/42"

>> s.extract
=> "users"

>> s.prev
=> "/users"

>> s.curr
=> "/42"

>> s.retract
=> "users"

>> s.prev
=> ""

>> s.curr
=> "/users/42"
```

And now `restore`:

```ruby
>> s = Seg.new("/users/42")
=> #<Seg ...>

>> s.prev
=> ""

>> s.curr
=> "/users/42"

>> s.extract
=> "users"

>> s.prev
=> "/users"

>> s.curr
=> "/42"

>> s.restore("foo")
=> false

>> s.restore("users")
=> true

>> s.prev
=> ""

>> s.curr
=> "/users/42"
```

See also
--------

[Syro][syro] is a routing library that uses `Seg` for matching the
request path.

[syro]: http://soveran.github.io/syro/

Installation
------------

```
$ gem install seg
```
