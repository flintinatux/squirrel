describe('invert', function()
  local list = { 'a', 'b' }
  local orig = { color = 'red', name = 'bob' }

  it('inverts a table', function()
    assert.is.same(invert(orig), { red = 'color', bob = 'name' })
  end)

  it('inverts a list, too', function()
    assert.is.same(invert(list), { a = 1, b = 2 })
  end)

  it('is curried', function()
    assert.is.same(invert()(orig), { red = 'color', bob = 'name' })
  end)

  it('first arg must be table', function()
    assert.has_error(
      partial(invert, { 'orig' }),
      'invert: first arg must be table, got string')
  end)
end)
