describe('equals', function()
  it('returns true if args are equivalent', function()
    assert.is_true(equals(1, 1))
  end)

  it('returns true if args are same ref', function()
    local obj = {}
    assert.is_true(equals(obj, obj))
  end)

  it('returns false if args are not equivalent', function()
    assert.is_false(equals(1, 2))
  end)

  it('returns false if args are not same ref', function()
    local a, b = {}, {}
    assert.is_false(equals(a, b))
  end)
end)
