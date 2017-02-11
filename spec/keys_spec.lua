describe('keys', function()
  local obj = { a = 1, b = 2, c = 3 }

  it('returns a list of keys on a table', function()
    local names = invert(keys(obj))
    for _, name in ipairs({ 'a', 'b', 'c' }) do
      assert.is.truthy(names[name])
    end
  end)

  it('is curried', function()
    local names = invert(keys()(obj))
    for _, name in ipairs({ 'a', 'b', 'c' }) do
      assert.is.truthy(names[name])
    end
  end)

  it('first arg must be table', function()
    assert.has_error(
      partial(keys, { 'obj' }),
      'keys: first arg must be table, got string')
  end)
end)
