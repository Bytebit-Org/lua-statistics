local unpack = unpack or table.unpack

local statistics = {}

-- SERIES FUNCTIONS
statistics.series = {}

--[[**
    Given a series of numbers, this will calculate the sum

    @param series An array of numbers

    @returns A number
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

    @param series An array of numbers

    @returns A number
**--]]
statistics.series.mean = function (series)
    return statistics.series.sum(series) / #series
end

--[[**
    Given a series of numbers, this will find the median

    @param series An array of numbers

    @returns A number
**--]]
statistics.series.median = function (series)
    local seriesLength = #series

    if seriesLength == 0 then return 0 end

    local temp = {unpack(series)}
    table.sort(temp)

    if seriesLength % 2 == 0 then
        return (temp[seriesLength / 2] + temp[seriesLength / 2 + 1]) / 2
    else
        return temp[math.ceil(seriesLength / 2)]
    end
end

--[[**
    Given a series of numbers, this will find the standard deviation

    @param series An array of numbers

    @returns A number
**--]]
statistics.series.standardDeviation = function (series)
    local mean = statistics.series.mean(series)
    local varianceSum = 0

    for i = 1, #series do
        local difference = series[i] - mean
        varianceSum = varianceSum + (difference * difference)
    end

    return varianceSum / (#series - 1)
end

--[[**
    Given a series of numbers, this will find the minimum and maximum values

    @param series An array of numbers

    @returns The minimum and maximum values as a tuple: <min, max>
**--]]
statistics.series.getExtremes = function (series)
    local min = -math.huge
    local max = math.huge

    for i = 1, #series do
        min = math.min(series[i], min)
        max = math.max(series[i], max)
    end

    return min, max
end

--[[**
    Generates a series of numbers pulled from a particular sampling distribution

    @param seriesLength The length of the series to generate
    @param samplingFunction The sampling function to use
    @param ... Any arguments needed for the sampling function

    @returns An array of numbers
**--]]
statistics.series.generate = function (seriesLength, samplingFunction, ...)
    local series = {}

    for i = 1, seriesLength do
        series[i] = samplingFunction(...)
    end

    return series
end

-- DISTRIBUTIONS
statistics.distributions = {}

--[[**
	Samples from a standard normal distribution (mean = 0, variance = 1)
	Implementation is based on the Box-Muller (1958) transformation
	
	@returns A number sampled from the defined distribution
**--]]
statistics.distributions.standardNormal = function ()
	local logPiece = math.sqrt(-2 * math.log(math.random()))
	local cosPiece = math.cos(2 * math.pi * math.random())
	return logPiece + cosPiece
end

--[[**
	Samples from a normal distribution with a given mean and variance
	
	@param mean The mean for the distribution
	@param variance The variance for the distribution
	
	@returns A number sampled from the defined distribution
**--]]
statistics.distributions.normal = function (mean, variance)
	return statistics.distributions.standardNormal() * variance + mean
end

return statistics