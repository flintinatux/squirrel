describe('reduce', function()
  local list = { 1, 2, 3 }

  it('reduces a list over a function starting with an accumulator', function()
    assert.is.equal(reduce(add, 0, list), 6)
  end)

  it('is curried', function()
    assert.is.equal(reduce(add)(0, list), 6)
    assert.is.equal(reduce(add, 0)(list), 6)
    assert.is.equal(reduce(add)(0)(list), 6)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(reduce, { 'add', 0, list }),
      'reduce: first arg must be function, got string')
  end)

  it('third arg must be list', function()
    assert.has_error(
      partial(reduce, { add, 0, 'list' }),
      'reduce: third arg must be list, got string')
  end)
end)
