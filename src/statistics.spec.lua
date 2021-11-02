return function()
	local statistics = require(script.Parent.statistics)
	local generatedSeriesLength = 100000
	local epsilon = 0.05

	it("should give accurate statistical measures", function()
		local odd = { 1, 2, 3, 4, 5 } -- Odd length series
		local even = { 1, 1, 2, 3, 4, 5 } -- Even length series

		expect(statistics.series.sum(odd)).to.equal(15)
		expect(statistics.series.mean(odd)).to.equal(3)
		expect(statistics.series.median(odd)).to.equal(3)
		expect(statistics.series.median(even)).to.equal(2.5)
		expect(statistics.series.mode(even)).to.equal(1)
		expect(statistics.series.standardDeviation(odd)).to.be.near(1.414213562)

		-- Check that the mode function can return multiple values
		do
			local mode = statistics.series.mode({1, 1, 2, 2})
			expect(#mode).to.equal(2)
			expect(mode[1]).to.equal(1)
			expect(mode[2]).to.equal(2)
		end

		local min, max = statistics.series.getExtremes(odd)
		expect(min).to.equal(1)
		expect(max).to.equal(5)
	end)

	it("should generate series properly", function()
		local generatedSeries = statistics.series.generate(5, function() return 1 end)

		expect(#generatedSeries).to.equal(5)
		expect(generatedSeries[1]).to.equal(1)
	end)

	it("should give approximate normal distributions", function()
		local standardNormalSeries = statistics.series.generate(
			generatedSeriesLength,
			statistics.distributions.standardNormal
		)
		expect(statistics.series.mean(standardNormalSeries)).to.be.near(0, epsilon)
		expect(statistics.series.standardDeviation(standardNormalSeries)).to.be.near(1, epsilon)

		local nonStandardNormalSeries = statistics.series.generate(
			generatedSeriesLength,
			statistics.distributions.normal, 1, 1
		)
		expect(statistics.series.mean(nonStandardNormalSeries)).to.be.near(1, epsilon)
		expect(statistics.series.standardDeviation(nonStandardNormalSeries)).to.be.near(1, epsilon)
	end)

	it("should give approximate exponential distributions", function()
		local lambda = 2

		local exponentialSeries = statistics.series.generate(
			generatedSeriesLength,
			statistics.distributions.exponential,
			lambda
		)
		expect(statistics.series.mean(exponentialSeries)).to.be.near(1 / lambda, epsilon)
		expect(statistics.series.variance(exponentialSeries)).to.be.near(1 / (lambda * lambda), epsilon)
	end)

	it("should give approximate binomial distributions", function()
		-- This will inherently also test the bernoulli distribution

		local n = 100
		local p = 0.5

		local binomalSeries = statistics.series.generate(
			generatedSeriesLength,
			statistics.distributions.binomial,
			n,
			p
		)
		expect(statistics.series.mean(binomalSeries)).to.be.near(n * p, epsilon)
		expect(statistics.series.variance(binomalSeries)).to.be.near(n * p * (1 - p), epsilon)
	end)

	it("should give approximate standard discrete distributions", function()
		local standardDiscreteSeries = statistics.series.generate(
			generatedSeriesLength,
			statistics.distributions.standardDiscrete,
			{0.01, 0.99},
			{0, 1}
		)
		expect(statistics.series.mean(standardDiscreteSeries)).to.be.near(1, epsilon)

		expect(statistics.distributions.standardDiscrete({-0.1, -0.1}, {1, 2})).to.equal(2)
	end)

	it("should give approximate geometric distributions", function()
		local p = 0.5

		local exponentialSeries = statistics.series.generate(
			generatedSeriesLength,
			statistics.distributions.geometric,
			p
		)
		expect(statistics.series.mean(exponentialSeries)).to.be.near((1 - p) / p, epsilon)
		expect(statistics.series.variance(exponentialSeries)).to.be.near((1 - p) / (p * p), epsilon)
	end)
end