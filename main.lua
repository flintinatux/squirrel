require('squirrel').import()

local addFive = compose(add(2), add(3))
print(addFive(6))

local nums = map(addFive, { 1, 2, 3 })
print(unpack(nums))

local fullname = function(first, last, suffix)
  return first .. ' ' .. last .. ' ' .. suffix
end
print(flip(fullname)('McCormack')('Scott')('Jr.'))
