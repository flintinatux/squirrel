describe('partial', function()
  local arg1, arg2 = {}, {}

  it('partially applies args to a function', function()
    local res1, res2 = partial(identity, { arg1 })(arg2)
    assert.is.equal(res1, arg1)
    assert.is.equal(res2, arg2)
  end)

  it('is curried', function()
    local res1, res2 = partial(identity)({ arg1 })(arg2)
    assert.is.equal(res1, arg1)
    assert.is.equal(res2, arg2)
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(partial, { 'function', { 1 } }),
      'partial: first arg must be function, got string')
  end)

  it('second arg must be list', function()
    assert.has_error(
      partial(partial, { identity, 'list' }),
      'partial: second arg must be list, got string')
  end)
end)
