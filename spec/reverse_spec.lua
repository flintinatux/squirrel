describe('reverse', function()
  local list = { 1, 2, 3 }

  it('reverses a list', function()
    assert.is.same(reverse(list), { 3, 2, 1 })
  end)

  it('return a new list instance', function()
    assert.is_not.equal(reverse(list), list)
  end)

  it('first arg must be list', function()
    assert.has_error(
      partial(reverse, { 'list' }),
      'reverse: first arg must be list, got string')
  end)
end)
