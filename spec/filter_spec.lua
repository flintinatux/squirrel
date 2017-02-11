describe('filter', function()
  local list = { 1, 'two', 3 }

  it('filters a list based on a predicate', function()
    assert.is.same(filter(is('string'), list), { 'two' })
  end)

  it('is curried', function()
    assert.is.same(filter(is('string'))(list), { 'two' })
  end)

  it('returns a new list instance', function()
    assert.is_not.equal(filter(is('string'), list), list)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(filter, { 'pred', list }),
      'filter: first arg must be function, got string')
  end)

  it('second arg must be list', function()
    assert.has_error(
      partial(filter, { is('string'), 'list' }),
      'filter: second arg must be list, got string')
  end)
end)
