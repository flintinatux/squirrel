describe('any', function()
  local list = { 1, 2, 'three' }

  it('returns true if at least one elem in list matches pred', function()
    assert.is_true(any(is('string'), list))
  end)

  it('returns true if at least one elem in list matches pred', function()
    assert.is_false(any(is('table'), list))
  end)

  it('is curried', function()
    assert.is_true(any(is('string'))(list))
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(any, { true, list }),
      'any: first arg must be function, got boolean')
  end)

  it('second arg must be list', function()
    assert.has_error(
      partial(any, { is('string'), 1 }),
      'any: second arg must be list, got number')
  end)
end)
