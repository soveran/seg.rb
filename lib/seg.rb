# encoding: UTF-8
#
# Copyright (c) 2015 Michel Martens
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
class Seg
  SLASH = "/".freeze

  def initialize(path)
    @path = path
    @size = path.size
    @pos = 1
  end

  def curr
    @path[@pos - 1, @size]
  end

  def prev
    @path[0, @pos - 1]
  end

  def move(offset)
    @pos += offset.succ
  end

  def root?
    @pos >= @size
  end

  def consume(str)
    if segments_left? && full_segments?(str) && match?(str)
      move(str.size)
      true
    else
      false
    end
  end

  def capture(sym, store)
    if segments_left?
      segment = determine_segment
      store[sym] = segment
      move(segment.size)
      true
    else
      false
    end
  end

  private

  def segments_left?
    !root?
  end

  def determine_segment
    len = (@path.index(SLASH, @pos) || @size) - @pos
    @path[@pos, len]
  end

  def full_segments?(str)
    [nil, SLASH].include?(@path[@pos + str.size])
  end

  def match?(str)
    @path[@pos, str.size] == str
  end
end
