describe('prop', function()
  local obj = { color = 'red', name = 'Bob' }

  it('returns indicated property of table', function()
    assert.is.equal(prop('color', obj), 'red')
    assert.is.equal(prop('name', obj), 'Bob')
  end)

  it('is curried', function()
    assert.is.equal(prop('color')(obj), 'red')
  end)

  it('first arg must be string', function()
    assert.has_error(
      partial(prop, { true, obj }),
      'prop: first arg must be string, got boolean')
  end)

  it('second arg must be table', function()
    assert.has_error(
      partial(prop, { 'color', 'obj' }),
      'prop: second arg must be table, got string')
  end)
end)
