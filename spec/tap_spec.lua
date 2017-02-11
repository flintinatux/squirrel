describe('tap', function()
  it('runs the given function and then returns orig args', function()
    assert.is.equal(tap(add(1))(1), 1)
  end)

  it('is curried', function()
    assert.is.equal(tap()(add(1))(1), 1)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(tap, { 'function' }),
      'tap: first arg must be function, got string')
  end)
end)
