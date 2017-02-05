describe('identity', function()
  local arg1, arg2 = {}, {}

  it('returns all the supplied args', function()
    local res1, res2 = identity(arg1, arg2)
    assert.is.equal(res1, arg1)
    assert.is.equal(res2, arg2)
  end)
end)
