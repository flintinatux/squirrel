describe('curry', function()
  local sum3 = function(a, b, c)
    return a + b + c
  end

  if _VERSION == 'Lua 5.1' then
    it('passes-thru the original function in Lua 5.1', function()
      assert.is.equal(curry(sum3), sum3)
    end)

    it('is curried', function()
      assert.is.equal(curry()(sum3), sum3)
    end)
  else
    it('curries the supplied function', function()
      local sum3 = curry(sum3)
      assert.is.equal(sum3(1, 2, 3), 6)
      assert.is.equal(sum3(1)(2, 3), 6)
      assert.is.equal(sum3(1, 2)(3), 6)
      assert.is.equal(sum3(1)(2)(3), 6)
    end)

    it('is curried', function()
      local sum3 = curry()(sum3)
      assert.is.equal(sum3(1, 2, 3), 6)
      assert.is.equal(sum3(1)(2, 3), 6)
      assert.is.equal(sum3(1, 2)(3), 6)
      assert.is.equal(sum3(1)(2)(3), 6)
    end)

    it('first arg must be function', function()
      assert.has_error(
        partial(curry, { 'function' }),
        'curry: first arg must be function, got string')
    end)
  end
end)
