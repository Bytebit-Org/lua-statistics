local statistics = {}

statistics.distribution = {}

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