describe('add', function()
  it('adds two numbers', function()
    assert.are.equal(add(1, 2), 3)
  end)

  it('is curried', function()
    assert.are.equal(add(1, 2), add(1)(2))
  end)

  it('first arg must be number', function()
    assert.has_error(
      partial(add, { '1', 2 }),
      'add: first arg must be number, got string')
  end)

  it('second arg must be number', function()
    assert.has_error(
      partial(add, { 1, '2' }),
      'add: second arg must be number, got string')
  end)
end)
