describe('is', function()
  local val = 'abc'

  it('checks if value is of specified type', function()
    assert.is_true(is('string', val))
    assert.is_false(is('number', val))
  end)

  it('is curried', function()
    assert.is_true(is('string')(val))
  end)

  it('first arg must be string', function()
    assert.has_error(
      partial(is, { 123, val }),
      'is: first arg must be string, got number')
  end)
end)
