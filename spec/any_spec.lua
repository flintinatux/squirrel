local s = require('squirrel')
local any, is, partial = s.any, s.is, s.partial

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

  it('1st arg must be a function', function()
    assert.has_error(
      partial(any, { true, list }),
      'any : 1st arg must be a function')
  end)

  it('2nd arg must be a list', function()
    assert.has_error(
      partial(any, { is('string'), 1 }),
      'any : 2nd arg must be a list')
  end)
end)
