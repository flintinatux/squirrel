describe('composeR', function()
  local f = composeR(add, multiply)
  local g = composeR(multiply, add)

  it('composes reducers right-to-left', function()
    assert.is.equal(f(1, 3), 6)
    assert.is.equal(g(1, 3), 12)
  end)

  if _VERSION == 'Lua 5.1' then
    it('ignores typechecking in Lua 5.1', function()
      assert.has_no.error(partial(composeR, { add, 'multiply' }))
    end)
  else
    it('vararg must be all functions', function()
      assert.has_error(
        partial(composeR, { add, 'multiply' }),
        'composeR: vararg must be all functions, got a string')
    end)
  end
end)
