describe('init', function()
  local list = { 1, 2, 3 }

  it('returns all but the last elem of a list', function()
    assert.is.same(init(list), { 1, 2 })
  end)

  it('returns a new list instance', function()
    assert.is_not.equal(init(list), list)
  end)

  it('is curried', function()
    assert.is.same(init()(list), { 1, 2 })
  end)

  it('first arg must be list', function()
    assert.has_error(
      partial(init, { 'list' }),
      'init: first arg must be list, got string')
  end)
end)
