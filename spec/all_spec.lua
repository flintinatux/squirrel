require('squirrel').import()

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

  it('1st arg must be a function', function()
    assert.has_error(
      partial(all, { 'number', good }),
      'all: 1st arg must be a function')
  end)

  it('2nd arg must be a list', function()
    assert.has_error(
      partial(all, { is('number'), 'good' }),
      'all: 2nd arg must be a list')
  end)
end)
