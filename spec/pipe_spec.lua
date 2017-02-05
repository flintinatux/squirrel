describe('pipe', function()
  local f = add(3)
  local g = multiply(2)
  local h = pipe(f, g)
  local i = pipe(g, f)

  it('pipes functions left-to-right', function()
    assert.is.equal(h(2), 10)
    assert.is.equal(i(2), 7)
  end)

  it('vararg must be all functions', function()
    assert.has_error(
      partial(pipe, { f, 'g' }),
      'pipe: vararg must be all functions, got a string')
  end)
end)
