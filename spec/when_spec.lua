describe('when', function()
  local isEven  = function(x) return x % 2 == 0 end
  local makeOdd = when(isEven, add(1))

  it('processes the onTrue when pred returns true', function()
    assert.is.equal(makeOdd(2), 3)
  end)

  it('passes thru args when pred returns false', function()
    assert.is.equal(makeOdd(3), 3)
  end)

  it('is curried', function()
    assert.is.equal(when(isEven)(add(1))(2), 3)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(when, { 'pred', add(1) }),
      'when: first arg must be function, got string')
  end)

  it('second arg must be function', function()
    assert.has_error(
      partial(when, { isEven, 'onTrue' }),
      'when: second arg must be function, got string')
  end)
end)
