describe('pipeR', function()
  local f = pipeR(add, multiply)
  local g = pipeR(multiply, add)

  it('composes reducers left-to-right', function()
    assert.is.equal(f(1, 3), 12)
    assert.is.equal(g(1, 3), 6)
  end)

  it('vararg must be all functions', function()
    assert.has_error(
      partial(pipeR, { add, 'multiply' }),
      'pipeR: vararg must be all functions, got a string')
  end)
end)
