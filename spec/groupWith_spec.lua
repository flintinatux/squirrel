describe('groupWith', function()
  local list = { 1, 1, 2, 2, 2, 3, 3, 4 }

  it('groups list by pred function', function()
    assert.is.same(groupWith(equals, list),
      { { 1, 1 }, { 2, 2, 2 }, { 3, 3 }, { 4 } })
  end)

  it('concatentations are equal to the orig list', function()
    assert.is.same(reduce(concat, {}, groupWith(equals, list)), list)
  end)

  it('is curried', function()
    assert.is.same(groupWith(equals)(list),
      { { 1, 1 }, { 2, 2, 2 }, { 3, 3 }, { 4 } })
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(groupWith, { 'pred', list }),
      'groupWith: first arg must be function, got string')
  end)

  it('second arg must be list', function()
    assert.has_error(
      partial(groupWith, { equals, 'list' }),
      'groupWith: second arg must be list, got string')
  end)
end)
