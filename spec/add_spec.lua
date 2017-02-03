local s = require('squirrel')
local add, partial = s.add, s.partial

describe('add', function()
  it('adds two numbers', function()
    assert.are.equal(add(1, 2), 3)
  end)

  it('is curried', function()
    assert.are.equal(add(1, 2), add(1)(2))
  end)

  it('1st arg must be a number', function()
    assert.has_error(
      partial(add, { '1', 2 }),
      'add : 1st arg must be a number')
  end)

  it('2nd arg must be a number', function()
    assert.has_error(partial(add, { 1, '2' }), 'add : 2nd arg must be a number')
  end)
end)
