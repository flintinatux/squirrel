describe('max', function()
  it('returns greater of two numbers', function()
    assert.is.equal(max(1, 2), 2)
  end)

  it('first arg must be number', function()
    assert.has_error(
      partial(max, { {}, 2 }),
      'max: first arg must be number, got table')
  end)

  it('second arg must be number', function()
    assert.has_error(
      partial(max, { 2, {} }),
      'max: second arg must be number, got table')
  end)
end)
