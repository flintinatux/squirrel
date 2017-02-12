describe('unfold', function()
  local upToFive = function(x)
    return x <= 5 and { x, x + 1 }
  end

  it('unfolds a seed to build a list', function()
    assert.is.same(unfold(upToFive, 1), { 1, 2, 3, 4, 5 })
    assert.is.same(unfold(upToFive, 4), { 4, 5 })
    assert.is.same(unfold(upToFive, 6), { })
  end)

  it('is curried', function()
    assert.is.same(unfold(upToFive)(1), { 1, 2, 3, 4, 5 })
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(unfold, { 'upToFive', 1 }),
      'unfold: first arg must be function, got string')
  end)
end)
