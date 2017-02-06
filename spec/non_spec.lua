describe('non', function()
  it('creates a logical opposite to the pred', function()
    assert.is_true(is('string', 'one'))
    assert.is_false(non(is('string'))('one'))
  end)

  it('first arg must be function', function()
    assert.has_error(
      partial(non, { 'pred' }),
      'non: first arg must be function, got string')
  end)
end)
