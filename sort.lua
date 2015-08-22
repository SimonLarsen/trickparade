local sort = {}

function sort.default_comparator(a, b)
	return a < b
end

--- Sorts an array using bubble sort
-- @param a Array to sort
-- @param t Function taking two arguments (a,b). Returns true if a < b, false otherwise.
function sort.bubblesort(a, t)
	if t == nil then t = sort.default_comparator end

	while true do
		swapped = false
		for i=2,#a do
			if t(a[i-1], a[i]) then
				local tmp = a[i-1]
				a[i-1] = a[i]
				a[i] = tmp
				swapped = true
			end
		end

		if swapped == false then return end
	end
end

--- Sorts an array using bubble sort
-- @param a Array to sort
-- @param t Function taking two arguments (a,b). Returns true if a < b, false otherwise
function sort.insertionsort(a, t)
	if t == nil then t = sort.default_comparator end

	for i = 2, #a do
		local j = i
		while j > 1 and t(a[j], a[j-1]) do
			local tmp = a[j-1]
			a[j-1] = a[j]
			a[j] = tmp
			j = j - 1
		end
	end
end

return sort
