describe('omit', function()
  local orig = { color = 'blue', name = 'bob' }

  it('omits keys from a table', function()
    assert.is.same(omit({ 'name' }, orig), { color = 'blue' })
  end)

  it('is curried', function()
    assert.is.same(omit({ 'name' })(orig), { color = 'blue' })
  end)

  it('first arg must be list of strings', function()
    assert.has_error(
      partial(omit, { 'name', orig }),
      'omit: first arg must be list, got string')
    assert.has_error(
      partial(omit, { { {} }, orig }),
      'omit: first arg must be list of strings, got table element')
  end)

  it('second arg must be table', function()
    assert.has_error(
      partial(omit, { { 'name' }, 'orig' }),
      'omit: second arg must be table, got string')
  end)
end)
