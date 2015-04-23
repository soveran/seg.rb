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
```ruby

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
```ruby

Installation
------------

```
$ gem install seg
```
