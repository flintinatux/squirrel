describe('all', function()
  local good = { 1, 2, 3 }
  local bad = { 1, 2, '3' }

  it('return true if all elements match the pred', function()
    assert.is_true(all(is('number'), good))
  end)

  it('return false if not all elements match the pred', function()
    assert.is_false(all(is('number'), bad))
  end)

  it('is curried', function()
    assert.is_true(all(is('number'))(good))
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(all, { 'number', good }),
      'all: first arg must be function, got string')
  end)

  it('second arg must be list', function()
    assert.has_error(
      partial(all, { is('number'), 'good' }),
      'all: second arg must be list, got string')
  end)
end)
