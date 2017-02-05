describe('tail', function()
  local list = { 1, 2, 3 }

  it('returns all but the first elem of a list', function()
    assert.is.same(tail(list), { 2, 3 })
  end)

  it('returns a new list instance', function()
    assert.is_not.equal(tail(list), list)
  end)

  it('first arg must be list', function()
    assert.has_error(
      partial(tail, { 'list' }),
      'tail: first arg must be list, got string')
  end)
end)
