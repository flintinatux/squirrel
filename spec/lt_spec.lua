describe('lt', function()
  it('returns true if first less than second', function()
    assert.is_true(lt(1, 2))
  end)

  it('returns false if first greater than second', function()
    assert.is_false(lt(2, 1))
  end)

  it('first arg must be number', function()
    assert.has_error(
      partial(lt, { {}, 2 }),
      'lt: first arg must be number, got table')
  end)

  it('second arg must be number', function()
    assert.has_error(
      partial(lt, { 2, {} }),
      'lt: second arg must be number, got table')
  end)
end)
