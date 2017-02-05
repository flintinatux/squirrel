describe('pick', function()
  local orig = { color = 'red', name = 'Sam' }

  it('picks out the keys you want', function()
    assert.is.same(pick({'color'}, orig), { color = 'red' })
  end)

  it('is curried', function()
    assert.is.same(pick({'color'})(orig), { color = 'red' })
  end)

  it('first arg must be list of strings', function()
    assert.has_error(
      partial(pick, { 'color', orig }),
      'pick: first arg must be list, got string')

    assert.has_error(
      partial(pick, { { 1 }, orig }),
      'pick: first arg must be list of strings, got number element')
  end)

  it('second arg must be table', function()
    assert.has_error(
      partial(pick, { {'color'}, 'red' }),
      'pick: second arg must be table, got string')
  end)
end)
