--- *A nimble functional library for Lua*<br/>
-- Source on [Github](http://github.com/flintinatux/squirrel)
-- @author [Scott McCormack](http://github.com/flintinatux)
-- @copyright 2017
-- @license [MIT](http://www.opensource.org/licenses/mit-license.php)
-- @release 0.0.1
-- @module squirrel

local assert, ipairs, pairs = assert, ipairs, pairs
local format, len, match = string.format, string.len, string.match
local getinfo, getlocal = debug.getinfo, debug.getlocal
local insert, remove = table.insert, table.remove
local unpack = table.unpack or unpack

local _assign, _cloneList, _concat, _curry, _curryN, _identity, _invert, _length, _noop, _partial, _pipe, _pipeR, _reverse, _validate

local add, all, any, compose, composeR, concat, constant, curry, curryN, each, equals, evolve, filter, flip, groupWith, gt, head, identity, ifElse, init, invert, is, keys, last, lt, map, max, merge, min, multiply, non, noop, omit, partial, pick, pipe, pipeR, pluck, prop, reduce, reverse, tail, tap, unfold, when

-- Constants

local FIVE_ONE = _VERSION == 'Lua 5.1'
local LUAJIT   = type(jit) == 'table'

local LEVEL = (FIVE_ONE and not LUAJIT) and 3 or 2
local ORD   = { 'first', 'second', 'third' }

-- Placeholders

-- `a -> a`.
_identity = function(...)
  return ...
end

-- `* -> ()`.
_noop = function() end

-- Internal

-- `({ s = a }, { s = a }) -> { s = a }`.
_assign = function(a, b)
  for k, v in pairs(b) do a[k] = v end
  return a
end

-- `[a] -> [a]`.
_cloneList = function(a)
  local b = {}
  for _, v in ipairs(a) do insert(b, v) end
  return b
end

-- `([a], [a]) -> [a]`.
_concat = function(a, b)
  local c = _cloneList(a)
  for _, v in ipairs(b) do insert(c, v) end
  return c
end

-- `((a, b) -> c) -> a -> b -> c`.
_curry = FIVE_ONE and _identity or function(f)
  return _curryN(_length(f), f)
end

-- `(number -> ((a, b) -> c)) -> a -> b -> c`.
_curryN = function(n, f)
  if n < 1 then return f end
  return function(...)
    local args = {...}
    if #args < n then
      return _curryN(n - #args, partial(f, args))
    else
      return f(...)
    end
  end
end

-- `{ s = a } -> { a = s }`.
_invert = function(a)
  local b = {}
  for k, v in pairs(a) do b[v] = k end
  return b
end

-- `function -> number`.
_length = function(f)
  return getinfo(f, 'u').nparams
end

-- `(((a, b, ...) -> z), [a, b, ...]) -> ((c, d, ...) -> z)`.
_partial = function(f, args)
  return function(...)
    return f(unpack(_concat(args, {...})))
  end
end

-- `((a -> b), ..., (y -> z)) -> a -> z`.
_pipe = function(...)
  local fs = {...}
  local first = remove(fs, 1)
  return function(...)
    local val = first(...)
    for _, f in ipairs(fs) do
      val = f(val)
    end
    return val
  end
end

-- `((b -> a -> b), ..., (b -> a -> b)) -> (b -> a -> b)`.
_pipeR = function(...)
  local fs = {...}
  return _curryN(2, function(acc, val)
    for _, f in ipairs(fs) do
      acc = f(acc, val)
    end
    return acc
  end)
end

-- `[a] -> [a]`.
_reverse = function(a)
  local b = {}
  for i = #a, 1, -1 do
    insert(b, a[i])
  end
  return b
end

-- `string -> ...string -> ()`.
_validate = _curryN(2, not _DEBUG and _noop or function(func, ...)
  for i, t in ipairs({...}) do
    local inner  = match(t, '^%[(%a+)%]$')
    local vararg = match(t, '^%.%.%.(%a+)$')

    local name, val = getlocal(LEVEL, i)
    local valType = type(val)
    local base, err

    if (inner) then
      base = format('%s: %s arg must be list', func, ORD[i])
      err  = base .. format(', got %s', valType)
      assert(valType == 'table', err)

      if (len(inner) > 1) then
        base = base .. format(' of %ss', inner)
        for _, v in ipairs(val) do
          valType = type(v)
          err = base .. format(', got %s element', valType)
          assert(valType == inner, err)
        end
      end

    elseif (vararg and len(vararg) > 1) then
      if not FIVE_ONE then
        base = format('%s: vararg must be all %ss', func, vararg)
        local j = -1
        name, val = getlocal(LEVEL, j)
        while val do
          valType = type(val)
          err = base .. format(', got a %s', valType)
          assert(valType == vararg, err)
          j = j - 1
          name, val = getlocal(LEVEL, j)
        end
      end

    elseif (len(t) > 1) then
      err = format('%s: %s arg must be %s, got %s', func, ORD[i], t, valType)
      assert(valType == t, err)
    end
  end
end)

-- API

--- `number -> number -> number`.
--
-- Adds two numbers.
-- @function add
-- @within Math
-- @tparam number a
-- @tparam number b
-- @treturn number The sum of the two numbers.
add = _curryN(2, function(a, b)
  _validate('add', 'number', 'number')
  return a + b
end)

--- `(a -> boolean) -> [a] -> boolean`.
--
-- Returns `true` if all elements in the list match the predicate,
-- `false` otherwise.
-- @function all
-- @within Predicate
-- @tparam function pred The predicate function.
-- @tparam table list The list to consider.
-- @treturn boolean Boolean `true` if the predicate is satisfied by all elements, `false` otherwise.
all = _curryN(2, function(pred, list)
  _validate('all', 'function', '[a]')
  for _, v in ipairs(list) do
    if not pred(v) then return false end
  end
  return true
end)

--- `(a -> boolean) -> [a] -> boolean`.
--
-- Returns `true` if at least one element in the list matches the predicate,
-- `false` otherwise.
-- @function any
-- @within Predicate
-- @tparam function pred The predicate function.
-- @tparam table list The list to consider.
-- @treturn boolean Boolean `true` if the predicate is satisfied by at least one element, `false` otherwise.
any = _curryN(2, function(pred, list)
  _validate('any', 'function', '[a]')
  for _, v in ipairs(list) do
    if pred(v) then return true end
  end
  return false
end)

--- `((y -> z), ..., (a -> b)) -> a -> z`.
--
-- Performs right-to-left function composition. The rightmost
-- function may have any arity. The remaining functions must be unary.
-- @function compose
-- @within Function
-- @tparam function ... The functions to compose.
-- @treturn function A new, composed function. (_not automatically curried_)
-- @see pipe
compose = function(...)
  _validate('compose', '...function')
  return _pipe(unpack(_reverse({...})))
end

--- `((b -> a -> b), ..., (b -> a -> b)) -> (b -> a -> b)`.
--
-- Performs right-to-left composition on reducers.  The result of each reduction
-- is passed to the next reducer in turn, along with the same "new value".
-- @function composeR
-- @within Function
-- @tparam function ... The reducers to compose.
-- @treturn function A new, composed reducer. (_is curried_)
composeR = function(...)
  _validate('composeR', '...function')
  return _pipeR(unpack(_reverse({...})))
end

--- `[a] -> [a] -> [a]`.
--
-- Concatenates two lists.
-- @function concat
-- @within List
-- @tparam table fst
-- @tparam table snd
-- @treturn table A new list contained elements of `fst` followed by elements of `snd`.
concat = _curryN(2, function(a, b)
  _validate('concat', '[a]', '[a]')
  return _concat(a, b)
end)

--- `a -> (b -> a)`.
--
-- Returns a function that always returns the given value.
-- @function constant
-- @within Function
-- @tparam any x The value to wrap in a function.
-- @treturn function The new, constant-value function.
constant = _curryN(1, function(val)
  return function()
    return val
  end
end)

--- `((a, b) -> c) -> a -> b -> c`.
--
-- Returns a curried equivalent of the provided function.
-- Arguments to curried function needn't be provided one at a time.
-- For example, if `f` is a ternary function, and `local g = curry(f)`,
-- then the following are equivalent:
--
--  - `g(1)(2)(3)`
--  - `g(1, 2)(3)`
--  - `g(1)(2, 3)`
--  - `g(1, 2, 3)`
--
-- **Note:** In Lua 5.1, `curry` falls back to `identity`, since the arity of a
-- function cannot be inspected by `debug.getinfo` until Lua 5.2.  If you need
-- 5.1, use `curryN` instead where possible.
-- @function curry
-- @within Function
-- @tparam function f The function to curry.
-- @treturn function A new, curried function.
-- @see curryN
curry = _curryN(1, function(f)
  _validate('curry', 'function')
  return _curry(f)
end)

--- `number -> ((a, b) -> c) -> a -> b -> c`.
--
-- Returns a curried equivalent of the provided function, with a
-- specified arity. Arguments to curried function needn't be
-- provided one at a time. For example, if `f` is a ternary function,
-- and `local g = curryN(3, f)`, then the following are equivalent:
--
--  - `g(1)(2)(3)`
--  - `g(1, 2)(3)`
--  - `g(1)(2, 3)`
--  - `g(1, 2, 3)`
-- @function curryN
-- @within Function
-- @tparam number arity The arity for the returned function.
-- @tparam function f The function to curry.
-- @treturn function A new, curried function.
-- @see curryN
curryN = _curryN(2, function(n, f)
  _validate('curryN', 'number', 'function')
  return _curryN(n, f)
end)

--- `(a -> b) -> [a] -> [a]`.
--
-- Iterate over an input list, calling a provided function for each element in
-- the list.  Useful for iterative side-effect work.
-- @function each
-- @within List
-- @tparam function f The function to invoke.
-- @tparam table list The list to iterate over.
-- @treturn table The original list.
each = _curryN(2, function(f, list)
  _validate('each', 'function', '[a]')
  for _, v in ipairs(list) do
    f(v)
  end
  return list
end)

--- `a -> b -> boolean`.
--
-- Returns `true` if its arguments are equivalent, `false` otherwise, based on
-- Lua equality (`==`).
-- @function equals
-- @within Predicate
-- @tparam any a
-- @tparam any b
-- @treturn boolean Boolean `true` if its arguments are equivalent, `false` otherwise.
equals = _curryN(2, function(a, b)
  return a == b
end)

--- `{ s = (a -> a) } -> { s = a } -> { s = a }`.
--
-- Creates a new table by recursively evolving a shallow copy of `table`,
-- according to the transform functions. All non-primitive properties
-- are copied by reference.
--
-- A transform function will not be invoked if its corresponding key
-- does not exist in the evolved table.
-- @function evolve
-- @within Table
-- @tparam table transforms The table specifying transform functions to apply.
-- @tparam table table The table to transform.
-- @treturn table A new, transformed table.
evolve = _curryN(2, function(xfrms, obj)
  _validate('evolve', 'table', 'table')
  local res = {}
  for key, val in pairs(obj) do
    local xfrm = xfrms[key]
    res[key] = type(xfrm) == 'function' and xfrm(val)
            or type(xfrm) == 'table'    and evolve(xfrm, val)
            or val
  end
  return res
end)

--- `(a -> boolean) -> [a] -> [a]`.
--
-- Returns a new list of all elements satisfying the given predicate.
-- @function filter
-- @within List
-- @tparam function pred The predicate with which to filter.
-- @tparam table list The original list.
-- @treturn table A new, filtered list.
filter = _curryN(2, function(pred, list)
  _validate('filter', 'function', '[a]')
  local res = {}
  for _, val in ipairs(list) do
    if pred(val) then insert(res, val) end
  end
  return res
end)

--- `(a -> b -> c) -> b -> a -> c`.
--
-- Returns a new function with the order of the first two arguments reversed.
-- @function flip
-- @within Function
-- @tparam function f The function to flip.
-- @treturn function A new, flipped function. (_is curried with arity 2_)
flip = _curryN(1, function(f)
  _validate('flip', 'function')
  return _curryN(2, function(a, b, ...)
    return f(b, a, ...)
  end)
end)

--- `((a, a) -> boolean) -> [a] -> [[a]]`.
--
-- Takes a list and returns a list of lists, where each sublist's elements are
-- all equivalent according to the provided function.
-- Only adjacent elements are passed to the comparison function.
-- @function groupWith
-- @within List
-- @tparam function pred The predicate to compare adjacent elements.
-- @tparam table list The list to consider.
-- @treturn table A list that contains sublists of elements, whose concatenations are equal to the original list.
groupWith = _curryN(2, function(pred, list)
  _validate('groupWith', 'function', '[a]')
  local res = { {} }
  for i, v in ipairs(list) do
    insert(res[#res], v)
    if i < #list and not pred(v, list[i+1]) then insert(res, {}) end
  end
  return res
end)

--- `number -> number -> boolean`.
--
-- Returns `true` if the first number is greater than the second, or `false`
-- otherwise.
-- @function gt
-- @within Predicate
-- @tparam number a
-- @tparam number b
-- @treturn boolean True if `a` is greater than `b`.
gt = _curryN(2, function(a, b)
  _validate('gt', 'number', 'number')
  return a > b
end)

--- `[a] -> a | nil`.
--
-- Returns the first element of the given list.
-- @function head
-- @within List
-- @tparam table list The original list.
-- @treturn any The first element of `list`, or `nil` if `list` is empty.
head = _curryN(1, function(list)
  _validate('head', '[a]')
  return list[1]
end)

--- `a -> a`.
--
-- A function that simply returns the arguments supplied to it.  Accepts
-- multiple input values, since Lua supports multiple return values.
-- @function identity
-- @within Function
-- @tparam any x The value(s) to return.
-- @treturn any The input value(s).
identity = _curryN(1, _identity)

--- `(a -> boolean) -> (a -> b) -> (a -> c) -> a -> b | c`.
--
-- Creates a function that will process either the `onTrue` or the `onFalse`
-- function depending upon the result of the predicate.
-- @function ifElse
-- @within Logic
-- @tparam function pred The predicate function.
-- @tparam function onTrue The function to call if `true`.
-- @tparam function onFalse The function to call if `false`.
-- @treturn any The result of calling either `onTrue` or `onFalse`.
ifElse = _curryN(3, function(pred, onTrue, onFalse)
  _validate('ifElse', 'function', 'function', 'function')
  return function(...)
    return pred(...) and onTrue(...) or onFalse(...)
  end
end)

--- `[a] -> [a]`.
--
-- Returns all but the last element of the given list.
-- @function init
-- @within List
-- @tparam table list The original list.
-- @treturn table A new list containing all but the last element of `list`.
init = _curryN(1, function(a)
  _validate('init', '[a]')
  local b = _cloneList(a)
  remove(b)
  return b
end)

--- `{ s = a } -> { a = s }`.
--
-- Returns a new table with the keys of the given table as values, and the values
-- of the given table as keys. Note that the last key found is preferred when
-- handling the same value. Also inverts lists.
-- @function invert
-- @within Table
-- @tparam table table The table to invert.
-- @treturn table A new inverted table.
invert = _curryN(1, function(orig)
  _validate('invert', 'table')
  return _invert(orig)
end)

--- `string -> a -> boolean`.
--
-- Returns `true` if a value is of the specified type.  Calls through to the builtin [`type`](http://devdocs.io/lua~5.3/index#pdf-type) function.
-- @function is
-- @within Predicate
-- @tparam string type Can be `"nil"` (a string, not the value nil), `"number"`, `"string"`, `"boolean"`, `"table"`, `"function"`, `"thread"`, or `"userdata"`.
-- @tparam any a The value to check.
-- @treturn boolean True if `type(a)` matches the specified type.
is = _curryN(2, function(typestring, a)
  _validate('is', 'string')
  return type(a) == typestring
end)

--- `{ s = a } -> [s]`.
--
-- Returns a list of all keys on a table. The order of the list is the same as
-- would be iterated via `pairs`, and as such is not guaranteed to be consistent.
-- @function keys
-- @within Table
-- @tparam table table The table from which to extract keys.
-- @treturn table The list of keys.
keys = _curryN(1, function(obj)
  _validate('keys', 'table')
  local res = {}
  for k, _ in pairs(obj) do insert(res, k) end
  return res
end)

--- `[a] -> a | nil`.
--
-- Returns the last element of the given list.
-- @function last
-- @within List
-- @tparam table list The original list.
-- @treturn any The last element of `list`, or `nil` if `list` is empty.
last = _curryN(1, function(list)
  _validate('last', '[a]')
  return list[#list]
end)

--- `number -> number -> boolean`.
--
-- Returns `true` if the first number is less than the second, or `false`
-- otherwise.
-- @function lt
-- @within Predicate
-- @tparam number a
-- @tparam number b
-- @treturn boolean True if `a` is less than `b`.
lt = _curryN(2, function(a, b)
  _validate('lt', 'number', 'number')
  return a < b
end)

--- `(a -> b) -> [a] -> [b]`.
--
-- Takes a function and a list, applies the function to each of the list's
-- values, and returns a list of the same shape.
-- @function map
-- @within List
-- @tparam function f The function to be called on every element of `list`.
-- @tparam table list The list to iterate over.
-- @treturn table The new list.
map = _curryN(2, function(f, a)
  _validate('map', 'function', '[a]')
  local b = {}
  for _, v in ipairs(a) do insert(b, f(v)) end
  return b
end)

--- `number -> number -> number`.
--
-- Returns the greater of two numbers.
-- @function max
-- @within Math
-- @tparam number a
-- @tparam number b
-- @treturn number Either `a` or `b`, whichever is greater.
max = _curryN(2, function(a, b)
  _validate('max', 'number', 'number')
  return a > b and a or b
end)

--- `{ s = a } -> { s = a } -> { s = a }`.
--
-- Creates a new table with the properties of the first table merged with the
-- properties of the second table. If a key exists in both tables, the value
-- from the second table will be used.
-- @function merge
-- @within Table
-- @tparam table fst The first table.
-- @tparam table snd The second table.
-- @treturn table A new merged table.
merge = _curryN(2, function(a, b)
  _validate('merge', 'table', 'table')
  local res = {}
  _assign(res, a)
  _assign(res, b)
  return res
end)

--- `number -> number -> number`.
--
-- Returns the lesser of two numbers.
-- @function min
-- @within Math
-- @tparam number a
-- @tparam number b
-- @treturn number Either `a` or `b`, whichever is lesser.
min = _curryN(2, function(a, b)
  _validate('min', 'number', 'number')
  return a < b and a or b
end)

--- `number -> number -> number`.
--
-- Multiplies two numbers.
-- @function multiply
-- @within Math
-- @tparam number a
-- @tparam number b
-- @treturn number The product of the two numbers.
multiply = _curryN(2, function(a, b)
  _validate('multiply', 'number', 'number')
  return a * b
end)

--- `(a -> boolean) -> (a -> boolean)`.
--
-- Creates a new function that returns the logical opposite of the supplied
-- predicate.
-- @function non
-- @within Logic
-- @tparam function pred The original predicate.
-- @treturn function A new function that returns the logical opposite of `pred`.
non = _curryN(1, function(pred)
  _validate('non', 'function')
  return function(...)
    return not pred(...)
  end
end)

--- `a -> ()`.
--
-- A function that does nothing and returns nothing.  Useful as a placeholder
-- or default function.
-- @function noop
-- @within Function
noop = _noop

--- `[string] -> { s = a } -> { s = a }`.
--
-- Returns a partial copy of a table omitting the keys specified.
-- @function omit
-- @within Table
-- @tparam table keys List of string keys to omit.
-- @tparam table table The original table.
-- @treturn table A new table with properties from `keys` not on it.
omit = _curryN(2, function(names, orig)
  _validate('omit', '[string]', 'table')
  local res = {}
  names = _invert(names)
  for key, val in pairs(orig) do
    if not names[key] then res[key] = val end
  end
  return res
end)

--- `((a, b, ...) -> z) -> [a, b, ...] -> ((c, d, ...) -> z)`.
--
-- Takes a function `f` and a list of arguments, and returns a function `g`.
-- When applied, `g` returns the result of applying `f` to the arguments
-- provided initially followed by the arguments provided to `g`.
-- @function partial
-- @within Function
-- @tparam function f The function to apply partially.
-- @tparam table args The args to apply to the `f`.
-- @treturn function A new, partially applied function.
partial = _curryN(2, function(f, args)
  _validate('partial', 'function', '[a]')
  return _partial(f, args)
end)

--- `[string] -> { s = a } -> { s = a }`.
--
-- Returns a partial copy of a table containing only the keys specified.
-- If the key does not exist, the property is ignored.
-- @function pick
-- @within Table
-- @tparam table keys List of keys to copy onto a new table.
-- @tparam table table The table to copy from.
-- @treturn table A new table with only properties from `keys` on it.
pick = _curryN(2, function(names, a)
  _validate('pick', '[string]', 'table')
  local b = {}
  for _, key in ipairs(names) do b[key] = a[key] end
  return b
end)

--- `((a -> b), ..., (y -> z)) -> a -> z`.
--
-- Performs left-to-right function composition. The leftmost
-- function may have any arity. The remaining functions must be unary.
-- @function pipe
-- @within Function
-- @tparam function ... The functions to pipe.
-- @treturn function A new, piped function. (_Not automatically curried._)
-- @see compose
pipe = function(...)
  _validate('pipe', '...function')
  return _pipe(...)
end

--- `((b -> a -> b), ..., (b -> a -> b)) -> (b -> a -> b)`.
--
-- Performs left-to-right composition on reducers.  The result of each reduction
-- is passed to the next reducer in turn, along with the same "new value".
-- @function pipeR
-- @within Function
-- @tparam function ... The reducers to compose.
-- @treturn function A new, composed reducer. (_is curried_)
pipeR = function(...)
  _validate('pipeR', '...function')
  return _pipeR(...)
end

--- `string -> [{ s = a }] -> [a]`.
--
-- Returns a new list by plucking the same named key off all tables in the
-- list supplied.
-- @function pluck
-- @within List
-- @tparam string key The key name to pluck off of each table.
-- @tparam table list The list to consider.
-- @treturn table The list of values for the given key.
pluck = _curryN(2, function(key, list)
  _validate('pluck', 'string', '[table]')
  local res = {}
  for i, elem in ipairs(list) do
    res[i] = elem[key]
  end
  return res
end)

--- `string -> { s = a } -> a | nil`.
--
-- Returns the indicated property of a table, if it exists.
-- @function prop
-- @within Table
-- @tparam string key The property to access.
-- @tparam table table The table to query.
-- @treturn any The value of that property, or `nil`.
prop = _curryN(2, function(key, table)
  _validate('prop', 'string', 'table')
  return table[key]
end)

--- `(b -> a -> b) -> b -> [a] -> b`.
--
-- Returns a single item by iterating through a list, successively calling
-- the iterator function and passing it an accumulator value and the current
-- value from the list, and then passing the result to the next call.
--
-- The iterator function receives two values: `(acc, value)`.
-- @function reduce
-- @within List
-- @tparam function f The iterator function.
-- @tparam any acc The accumulator value.
-- @tparam table list The list to iterate over.
-- @treturn any The final, accumulated value.
reduce = _curryN(3, function(f, acc, list)
  _validate('reduce', 'function', 'a', '[a]')
  for _, val in ipairs(list) do
    acc = f(acc, val)
  end
  return acc
end)

--- `[a] -> [a]`.
--
-- Returns a new list with the elements in reverse order.
-- @function reverse
-- @within List
-- @tparam table list The list to reverse.
-- @treturn table A new, reversed list.
reverse = _curryN(1, function(a)
  _validate('reverse', '[a]')
  return _reverse(a)
end)

--- `[a] -> [a]`.
--
-- Returns all but the first element of the given list.
-- @function tail
-- @within List
-- @tparam table list The original list.
-- @treturn table A new list containing all but the first element of `list`.
tail = _curryN(1, function(a)
  _validate('tail', '[a]')
  local b = _cloneList(a)
  remove(b, 1)
  return b
end)

--- `(a -> b) -> a -> a`.
--
-- Creates a new function that first runs the original function, and then
-- returns the original arguments.
-- @function tap
-- @within Function
-- @tparam function f The function to wrap. Its return value will be discarded.
-- @treturn any A new, tapped function.
tap = _curryN(1, function(f)
  _validate('tap', 'function')
  return function(...)
    f(...)
    return ...
  end
end)

--- `(a -> { b, a } | boolean) -> a -> [b]`.
--
-- Builds a list from a seed value. Accepts an iterator function, which either
-- returns `false` to stop iteration, or a pair of values:
--
-- - `b` - The value to add to the resulting list.
-- - `a` - The seed to use in the next iteration.
-- @function unfold
-- @within List
-- @tparam function f The iterator function.
-- @tparam any seed The initial seed to start the unfold.
-- @treturn table The final list.
unfold = _curryN(2, function(f, seed)
  _validate('unfold', 'function', 'a')
  local res = {}
  local val = f(seed)
  while val do
    insert(res, val[1])
    val = f(val[2])
  end
  return res
end)

--- `(a -> boolean) -> (a -> b) -> a | b`.
--
-- Creates a function that will either process the `onTrue` or pass-through the
-- original aruments depending on the predicate result.
-- @function when
-- @within Logic
-- @tparam function pred The predicate function.
-- @tparam function onTrue The function to process when `pred` returns `true`.
-- @treturn any The result of either processing `onTrue` or passing-through the original arguments.
when = _curryN(2, function(pred, onTrue)
  _validate('when', 'function', 'function')
  return function(...)
    return pred(...) and onTrue(...) or ...
  end
end)

-- Module

local squirrel = {
  add       = add,
  all       = all,
  any       = any,
  compose   = compose,
  composeR  = composeR,
  concat    = concat,
  constant  = constant,
  curry     = curry,
  curryN    = curryN,
  each      = each,
  equals    = equals,
  evolve    = evolve,
  filter    = filter,
  flip      = flip,
  groupWith = groupWith,
  gt        = gt,
  head      = head,
  identity  = identity,
  ifElse    = ifElse,
  init      = init,
  invert    = invert,
  is        = is,
  keys      = keys,
  last      = last,
  lt        = lt,
  map       = map,
  max       = max,
  merge     = merge,
  min       = min,
  multiply  = multiply,
  omit      = omit,
  non       = non,
  noop      = noop,
  partial   = partial,
  pick      = pick,
  pipe      = pipe,
  pipeR     = pipeR,
  pluck     = pluck,
  prop      = prop,
  reduce    = reduce,
  reverse   = reverse,
  tail      = tail,
  tap       = tap,
  unfold    = unfold,
  when      = when
}

squirrel.import = function(ctx)
  ctx = ctx or _G
  return _assign(ctx, squirrel)
end

return squirrel
