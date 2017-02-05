describe('evolve', function()
  local multClicks = evolve({ clicks = multiply(2) })

  it('evolves a table using the transform functions', function()
    assert.is.same(evolve({ total = add(1) }, { total = 1 }), { total = 2 })
  end)

  it('ignores transforms for missing keys', function()
    assert.is.same(evolve({ clicks = add(1) }, { total = 1 }), { total = 1 })
  end)

  it('returns a new table instance', function()
    local orig = { total = 1 }
    assert.is_not.equal(evolve({ total = identity }, orig), orig)
  end)

  it('is curried', function()
    assert.is.same(evolve({ total = add(1) })({ total = 1 }), { total = 2 })
  end)

  it('recursively transforms', function()
    assert.is.same(evolve({
      clicks = { total = add(1) }
    }, {
      clicks = { total = 1 }
    }), {
      clicks = { total = 2 }
    })
  end)

  it('first arg must be table', function()
    assert.has_error(
      partial(evolve, { add(1), { total = 1 } }),
      'evolve: first arg must be table, got function')
  end)

  it('second arg must be table', function()
    assert.has_error(
      partial(evolve, { { total = add(1) }, 1 }),
      'evolve: second arg must be table, got number')
  end)
end)
