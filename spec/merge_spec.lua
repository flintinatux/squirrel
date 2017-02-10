describe('merge', function()
  local fst = { color = 'blue', name = 'bob' }
  local snd = { color = 'red' }

  it('merges two tables', function()
    assert.is.same(merge(fst, snd), { color = 'red', name = 'bob' })
  end)

  it('is curried', function()
    assert.is.same(merge(fst)(snd), { color = 'red', name = 'bob' })
  end)

  it('returns a new table instance', function()
    assert.is_not.equal(merge(fst, snd), fst)
    assert.is_not.equal(merge(fst, snd), snd)
  end)

  it('first arg must be table', function()
    assert.has_error(
      partial(merge, { 'fst', snd }),
      'merge: first arg must be table, got string')
  end)

  it('second arg must be table', function()
    assert.has_error(
      partial(merge, { fst, 'snd' }),
      'merge: second arg must be table, got string')
  end)
end)
