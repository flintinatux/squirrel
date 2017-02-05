describe('ifElse', function()
  local isEven = function(x) return x % 2 == 0 end
  local makeOdd = ifElse(isEven, add(1), identity)

  it('processes the onTrue if pred returns true', function()
    assert.is.equal(makeOdd(2), 3)
  end)

  it('processes the onFalse if pred returns false', function()
    assert.is.equal(makeOdd(3), 3)
  end)

  it('is curried', function()
    assert.is.equal(ifElse(isEven)(add(1), identity)(2), 3)
    assert.is.equal(ifElse(isEven, add(1))(identity)(2), 3)
    assert.is.equal(ifElse(isEven)(add(1))(identity)(2), 3)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(ifElse, { 'pred', add(1), identity }),
      'ifElse: first arg must be function, got string')
  end)

  it('second arg must be function', function()
    assert.has_error(
      partial(ifElse, { isEven, 'onTrue', identity }),
      'ifElse: second arg must be function, got string')
  end)

  it('third arg must be function', function()
    assert.has_error(
      partial(ifElse, { isEven, add(1), 'onFalse' }),
      'ifElse: third arg must be function, got string')
  end)
end)
