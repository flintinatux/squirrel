require('squirrel').import()

describe('curryN', function()
  local sum3 = curryN(3, function(a, b, c)
    return a + b + c
  end)

  it('curries the supplied function', function()
    assert.is.equal(sum3(1, 2, 3), 6)
    assert.is.equal(sum3(1)(2, 3), 6)
    assert.is.equal(sum3(1, 2)(3), 6)
    assert.is.equal(sum3(1)(2)(3), 6)
  end)

  it('1st arg must be a number', function()
    assert.has_error(
      partial(curryN, { '3', function() end }),
      'curryN: 1st arg must be a number')
  end)
end)
