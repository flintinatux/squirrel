describe('compose', function()
  local f = add(3)
  local g = multiply(2)
  local h = compose(f, g)
  local i = compose(g, f)

  it('composes functions right-to-left', function()
    assert.is.equal(h(2), 7)
    assert.is.equal(i(2), 10)
  end)

  it('vararg must be all functions', function()
    assert.has_error(
      partial(compose, { f, 'g' }),
      'compose: vararg must be all functions, got a string')
  end)
end)
