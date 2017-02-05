describe('last', function()
  local list = { 1, 2, 3 }

  it('returns last elemt of list', function()
    assert.is.equal(last(list), 3)
  end)

  it('first arg must be list', function()
    assert.has_error(
      partial(last, { 'list' }),
      'last: first arg must be list, got string')
  end)
end)
