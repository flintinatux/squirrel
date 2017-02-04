local s = require('squirrel')
local concat, partial = s.concat, s.partial

describe('concat', function()
  local fst = { 1, 2 }
  local snd = { 3, 4 }

  it('concatenates two lists', function()
    assert.is.same(concat(fst, snd), { 1, 2, 3, 4 })
  end)

  it('is curried', function()
    assert.is.same(concat(fst)(snd), { 1, 2, 3, 4 })
  end)

  it('1st arg must be a list', function()
    assert.has_error(
      partial(concat, { 'fst', snd }),
      'concat: 1st arg must be a list')
  end)

  it('2nd arg must be a list', function()
    assert.has_error(
      partial(concat, { fst, 'snd' }),
      'concat: 2nd arg must be a list')
  end)
end)
