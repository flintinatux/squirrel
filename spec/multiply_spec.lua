describe('multiply', function()
  it('multiplies two numbers', function()
    assert.is.equal(multiply(2, 3), 6)
  end)

  it('is curried', function()
    assert.is.equal(multiply(2)(3), 6)
  end)

  it('first arg must be number', function()
    assert.has_error(
      partial(multiply, { '2', 3 }),
      'multiply: first arg must be number, got string')
  end)

  it('second arg must be number', function()
    assert.has_error(
      partial(multiply, { 2, '3' }),
      'multiply: second arg must be number, got string')
  end)
end)
