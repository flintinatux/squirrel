describe('flip', function()
  local f = function(a, b, c)
    return a .. b .. c
  end

  it('flips the first two args', function()
    assert.is.equal(flip(f)('a', 'b', 'c'), 'bac')
  end)

  it('curries the flipped function', function()
    assert.is.equal(flip(f)('a', 'b')('c'), 'bac')
    assert.is.equal(flip(f)('a')('b', 'c'), 'bac')
    assert.is.equal(flip(f)('a')('b')('c'), 'bac')
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(flip, { 'function() end' }),
      'flip: first arg must be function, got string')
  end)
end)
