describe('each', function()
  local i
  local count = function(x) i = i + 1 end
  local list = { 'a', 'b', 'c', 'd', 'e' }

  before_each(function()
    i = 0
  end)

  it('iterates a function over a list', function()
    each(count, list)
    assert.is.equal(i, 5)
  end)

  it('returns the orig list', function()
    assert.is.equal(each(count, list), list)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(each, { 'count', list }),
      'each: first arg must be function, got string')
  end)

  it('second arg must be list', function()
    assert.has_error(
      partial(each, { count, 'list' }),
      'each: second arg must be list, got string')
  end)
end)
