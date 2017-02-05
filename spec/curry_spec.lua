describe('curry', function()
  local sum3 = curry(function(a, b, c)
    return a + b + c
  end)

  it('curries the supplied function', function()
    assert.is.equal(sum3(1, 2, 3), 6)
    assert.is.equal(sum3(1)(2, 3), 6)
    assert.is.equal(sum3(1, 2)(3), 6)
    assert.is.equal(sum3(1)(2)(3), 6)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(curry, { 'function' }),
      'curry: first arg must be function, got string')
  end)
end)
