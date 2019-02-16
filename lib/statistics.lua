local function shallowCopyArray(array)
	local copy = {}

	for i = 1, #array do
		copy[i] = array[i]
	end

	return copy
end

local statistics = {}

--[[ SERIES FUNCTIONS ]]--
statistics.series = {}

--[[**
	Given a series of numbers, this will calculate the sum

	@param [t:array<number>] series An array of numbers

	@returns [t:number] A number
**--]]
statistics.series.sum = function (series)
	local sum = 0

	for i = 1, #series do
		sum = sum + series[i]
	end

	return sum
end

--[[**
	Given a series of numbers, this will calculate the mean

	@param [t:array<number>] series An array of numbers

	@returns [t:number] A number
**--]]
statistics.series.mean = function (series)
	return statistics.series.sum(series) / #series
end

--[[**
	Given a series of numbers, this will find the median

	@complexity Time O(n lg(n))
	@complexity Memory O(n)

	@param [t:array<number>] series An array of numbers

	@returns [t:number] A number
**--]]
statistics.series.median = function (series)
	local seriesLength = #series

	local temp = shallowCopyArray(series)
	table.sort(temp)

	if seriesLength % 2 == 0 then
		return (temp[seriesLength / 2] + temp[seriesLength / 2 + 1]) / 2
	else
		return temp[math.ceil(seriesLength / 2)]
	end
end

--[[**
	Given a series of values, this will find the mode
	If there is a tie, then all the values that tied will be returned as a sorted array.
	Note that this function will work regardless of data type; The data types just need to be sortable in some way and have a method of equality

	@complexity Time O(n lg(n))
	@complexity Memory O(n)

	@param [t:array<any>] series An array of values

	@returns [t:any] If there was a tie, then a sorted array; otherwise a number
**--]]
statistics.series.mode = function (series)
	local temp = shallowCopyArray(series)
	table.sort(temp)

	local actualModes = { temp[1] }
	local actualModeCount = 1

	local currentValue = temp[1]
	local currentValueCount = 1

	for i = 2, #temp do
		if temp[i] == currentValue then
			currentValueCount = currentValueCount + 1
		else
			currentValue = temp[i]
			currentValueCount = 1
		end

		if currentValueCount == actualModeCount then
			table.insert(actualModes, currentValue)
		elseif currentValueCount > actualModeCount then
			actualModes = { currentValue }
			actualModeCount = currentValueCount
		end
	end

	if #actualModes == 1 then
		return actualModes[1]
	else
		return actualModes
	end
end

--[[**
	Given a series of numbers, this will find the variance

	@param [t:array<number>] series An array of numbers

	@returns [t:number] A number
**--]]
statistics.series.variance = function (series)
	local mean = statistics.series.mean(series)
	local varianceSum = 0

	for i = 1, #series do
		local difference = series[i] - mean
		varianceSum = varianceSum + (difference * difference)
	end

	return varianceSum / #series
end

--[[**
	Given a series of numbers, this will find the standard deviation

	@param [t:array<number>] series An array of numbers

	@returns [t:number] A number
**--]]
statistics.series.standardDeviation = function (series)
	return math.sqrt(statistics.series.variance(series))
end

--[[**
	Given a series of numbers, this will find the minimum and maximum values

	@param [t:array<number>] series An array of numbers

	@returns [t:tuple<number, number>] The minimum and maximum values as a tuple: <min, max>
**--]]
statistics.series.getExtremes = function (series)
	assert(#series > 0, "Cannot find extremes on an empty list")

	local min = series[1]
	local max = series[1]

	for i = 2, #series do
		min = math.min(series[i], min)
		max = math.max(series[i], max)
	end

	return min, max
end

--[[**
	Generates a series of numbers pulled from a particular sampling distribution

	@param [t:number] seriesLength The length of the series to generate
	@param [t:function] samplingFunction The sampling function to use
	@param [t:any] ... Any arguments needed for the sampling function

	@returns [t:array<number>] An array of numbers
**--]]
statistics.series.generate = function (seriesLength, samplingFunction, ...)
	local series = {}

	for i = 1, seriesLength do
		series[i] = samplingFunction(...)
	end

	return series
end

--[[ DISTRIBUTION FUNCTIONS ]]--
statistics.distributions = {}

--[[ Continuous Distributions ]]--

--[[**
	Samples from a standard normal distribution (mean = 0, variance = 1)
	Implementation is based on the Box-Muller (1958) transformation

	@returns [t:number] A number sampled from the defined distribution
**--]]
statistics.distributions.standardNormal = function ()
	local u1, u2
	repeat u1 = math.random() u2 = math.random() until u1 > 0.0001

	local logPiece = math.sqrt(-2 * math.log(u1))
	local cosPiece = math.cos(2 * math.pi * u2)

	return logPiece * cosPiece
end

--[[**
	Samples from a normal distribution with a given mean and variance

	@param [t:number] mean The mean for the distribution
	@param [t:number] variance The variance for the distribution

	@returns [t:number] A number sampled from the defined distribution
**--]]
statistics.distributions.normal = function (mean, variance)
	return statistics.distributions.standardNormal() * math.sqrt(variance) + mean
end

--[[**
	Samples from an exponential distribution with a given rate

	@param [t:number] rate The rate for the distribution

	@returns [t:number] A number sampled from the defined distribution
**--]]
statistics.distributions.exponential = function (rate)
	return -math.log(1 - math.random()) / rate
end

--[[ Discrete Distributions ]]--

--[[**
	Samples from a bernoulli distribution with given probability

	@param [t:number] successProbability The probability of obtaining a 1

	@returns [t:number] A 0 or a 1, according to the distribution
**--]]
statistics.distributions.bernoulli = function (successProbability)
	if math.random() >= successProbability then
		return 1
	else
		return 0
	end
end

--[[**
	Samples from a binomial distribution with given probability and number of trials

	@param [t:number] numberOfTrials The number of trials for the distribution
	@param [t:number] successProbability The probability of a success on any given trial

	@returns [t:number] A non-negative integer in the range [0, numberOfTrials], according to the defined distribution
**--]]
statistics.distributions.binomial = function (numberOfTrials, successProbability)
	local successCount = 0

	for _ = 1, numberOfTrials do
		successCount = successCount + statistics.distributions.bernoulli(successProbability)
	end

	return successCount
end

--[[**
	Samples from a given discrete distribution

	@param [t:array<number>] distribution An array of numbers that should sum to 1
	@param [t:array<any>] values An array of values of the same length as distribution

	@returns [t:any] A value sampled according to the given distribution
**--]]
statistics.distributions.standardDiscrete = function (distribution, values)
	assert(#distribution == #values, "Distribution and values array lengths do not match")

	local r = math.random()
	local pSum = 0

	for i = 1, #distribution do
		pSum = pSum + distribution[i]
		if pSum >= r then
			return values[i]
		end
	end

	--Just in case
	return values[#values]
end

--[[**
	Samples from a geometric distribution with given success probability
	Note that this implementation allows for 0

	@param [t:number] successProbability The success probability parameter for the distribution

	@returns [t:number] A non-negative integer sampled from the defined distribution
**--]]
statistics.distributions.geometric = function (successProbability)
	return math.floor(math.log(math.random()) / math.log(1 - successProbability))
end

return statistics