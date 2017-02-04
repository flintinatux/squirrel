require('squirrel').import()

describe('pick', function()
  local orig = { color = 'red', name = 'Sam' }

  it('picks out the keys you want', function()
    assert.is.same(pick({'color'}, orig), { color = 'red' })
  end)

  it('is curried', function()
    assert.is.same(pick({'color'})(orig), { color = 'red' })
  end)

  it('1st arg must be a list of strings', function()
    assert.has_error(
      partial(pick, { 'color', orig }),
      'pick: 1st arg must be a list of strings')
  end)

  it('2nd arg must be a table', function()
    assert.has_error(
      partial(pick, { {'color'}, 'red' }),
      'pick: 2nd arg must be a table')
  end)
end)
