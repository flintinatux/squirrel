describe('map', function()
  local list = { 1, 2, 3 }

  it('maps a function over a list', function()
    assert.is.same(map(add(1), list), { 2, 3, 4 })
  end)

  it('is curried', function()
    assert.is.same(map(add(1))(list), { 2, 3, 4 })
  end)

  it('returns a new list instance', function()
    assert.is_not.equal(map(identity, list), list)
  end)

  it('first arg must be a function', function()
    assert.has_error(
      partial(map, { 'function', list }),
      'map: first arg must be function, got string')
  end)

  it('second arg must be a list', function()
    assert.has_error(
      partial(map, { add(1), 'list' }),
      'map: second arg must be list, got string')
  end)
end)
