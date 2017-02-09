describe('pluck', function()
  local list = { { color = 'red' }, { color = 'blue' }, { color = 'green' } }

  it('plucks the key off each list item', function()
    assert.is.same(pluck('color', list), { 'red', 'blue', 'green' })
  end)

  it('is curried', function()
    assert.is.same(pluck('color')(list), { 'red', 'blue', 'green' })
  end)

  it('first arg must be string', function()
    assert.has_error(
      partial(pluck, { {}, list }),
      'pluck: first arg must be string, got table')
  end)

  it('second arg must be list of tables', function()
    assert.has_error(
      partial(pluck, { 'color', {'red'} }),
      'pluck: second arg must be list of tables, got string element')
  end)
end)
