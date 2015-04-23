test "consume" do
  segment = Seg.new("/foo/bar/baz")

  assert_equal segment.consume("bar"), false
  assert_equal segment.prev, ""
  assert_equal segment.curr, "/foo/bar/baz"

  assert_equal segment.consume("foo"), true
  assert_equal segment.prev, "/foo"
  assert_equal segment.curr, "/bar/baz"

  assert_equal segment.consume("foo"), false
  assert_equal segment.prev, "/foo"
  assert_equal segment.curr, "/bar/baz"

  assert_equal segment.consume("bar"), true
  assert_equal segment.prev, "/foo/bar"
  assert_equal segment.curr, "/baz"

  assert_equal segment.consume("baz"), true
  assert_equal segment.prev, "/foo/bar/baz"
  assert_equal segment.curr, ""

  assert_equal segment.consume("baz"), false
  assert_equal segment.prev, "/foo/bar/baz"
  assert_equal segment.curr, ""
end

test "capture" do
  segment = Seg.new("/foo/bar/baz")

  captures = {}

  assert_equal segment.capture(:c1, captures), true
  assert_equal segment.prev, "/foo"
  assert_equal segment.curr, "/bar/baz"

  assert_equal segment.capture(:c2, captures), true
  assert_equal segment.prev, "/foo/bar"
  assert_equal segment.curr, "/baz"

  assert_equal segment.capture(:c3, captures), true
  assert_equal segment.prev, "/foo/bar/baz"
  assert_equal segment.curr, ""

  assert_equal segment.capture(:c4, captures), false
  assert_equal segment.prev, "/foo/bar/baz"
  assert_equal segment.curr, ""

  assert_equal "foo", captures[:c1]
  assert_equal "bar", captures[:c2]
  assert_equal "baz", captures[:c3]
  assert_equal nil, captures[:c4]
end
