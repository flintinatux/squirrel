describe('min', function()
  it('returns lesser of two numbers', function()
    assert.is.equal(min(1, 2), 1)
  end)

  it('first arg must be number', function()
    assert.has_error(
      partial(min, { {}, 2 }),
      'min: first arg must be number, got table')
  end)

  it('second arg must be number', function()
    assert.has_error(
      partial(min, { 2, {} }),
      'min: second arg must be number, got table')
  end)
end)
