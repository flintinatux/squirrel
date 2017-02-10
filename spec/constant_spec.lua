describe('constant', function()
  local a = constant('a')

  it('always returns the given value', function()
    assert.is.equal(a(), 'a')
  end)
end)
