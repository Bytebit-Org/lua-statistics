local Statistics = {}

Statistics.Distribution = {}

--[[**
	Samples from a standard normal distribution (mean = 0, variance = 1)
	Implementation is based on the Box-Muller (1958) transformation
	
	@returns A number sampled from the defined distribution
**--]]
Statistics.Distributions.StandardNormal = function ()
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
Statistics.Distributions.Normal = function (mean, variance)
	return Statistics.Distributions.StandardNormal() * variance + mean
end

return Statistics