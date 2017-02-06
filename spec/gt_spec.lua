describe('gt', function()
  it('returns true if first greater than second', function()
    assert.is_true(gt(2, 1))
  end)

  it('returns false if first less than second', function()
    assert.is_false(gt(1, 2))
  end)

  it('first arg must be number', function()
    assert.has_error(
      partial(gt, { {}, 2 }),
      'gt: first arg must be number, got table')
  end)

  it('second arg must be number', function()
    assert.has_error(
      partial(gt, { 2, {} }),
      'gt: second arg must be number, got table')
  end)
end)
