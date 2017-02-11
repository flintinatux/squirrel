describe('head', function()
  local list = { 1, 2, 3 }

  it('returns the first elem of list', function()
    assert.is.equal(head(list), 1)
  end)

  it('is curried', function()
    assert.is.equal(head()(list), 1)
  end)

  it('first arg must be list', function()
    assert.has_error(
      partial(head, { 'list' }),
      'head: first arg must be list, got string')
  end)
end)
