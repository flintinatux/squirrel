describe('concat', function()
  local fst = { 1, 2 }
  local snd = { 3, 4 }

  it('concatenates two lists', function()
    assert.is.same(concat(fst, snd), { 1, 2, 3, 4 })
  end)

  it('is curried', function()
    assert.is.same(concat(fst)(snd), { 1, 2, 3, 4 })
  end)

  it('first arg must be list', function()
    assert.has_error(
      partial(concat, { 'fst', snd }),
      'concat: first arg must be list, got string')
  end)

  it('second arg must be list', function()
    assert.has_error(
      partial(concat, { fst, 'snd' }),
      'concat: second arg must be list, got string')
  end)
end)
