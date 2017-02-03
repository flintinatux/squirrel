local add = require('squirrel').add

describe('add', function()
  it('adds two numbers', function()
    assert.are.equal(add(1, 2), 3)
  end)

  it('is curried', function()
    assert.are.equal(add(1, 2), add(1)(2))
  end)

  it('errors if first argument is not a number', function()
    assert.has_error(function() add('1', 2) end)
  end)

  it('errors if second argument is not a number', function()
    assert.has_error(function() add(1, '2') end)
  end)
end)
