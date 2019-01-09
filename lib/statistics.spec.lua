return function()
    local statistics = require(script.Parent.statistics)

    it("should give accurate statistical measures", function()
        local odd = { 1, 2, 3, 4, 5 } -- Odd length series
        local even = { 1, 2, 3, 4, 5, 6 } -- Even length series

        expect(statistics.series.sum(odd)).to.equal(15)
        expect(statistics.series.mean(odd)).to.equal(3)
        expect(statistics.series.median(odd)).to.equal(3)
        expect(statistics.series.median(even)).to.equal(3.5)
        expect(statistics.series.standardDeviation(odd)).to.be.near(1.5811388300842)

        local min, max = statistics.series.getExtremes(odd)
        expect(min).to.equal(1)
        expect(max).to.equal(5)
    end)

    it("should generate series properly", fucntion()
        local generatedSeries = statistics.series.generate(5, function() return 1 end)

        expect(#generatedSeries).to.equal(5)
        expect(generatedSeries[1]).to.equal(1)
    end)
    
    local seriesLength = 2500
    it("should give approximate distributions", function()
        local standardNormalSeries = statistics.series.generate(
            seriesLength,
            statistics.distributions.standardNormal
        )
		expect(statistics.series.mean(standardNormalSeries)).to.be.near(0)
        expect(statistics.series.standardDeviation(standardNormalSeries)).to.be.near(1)
        
        local nonStandardNormalSeries = statistics.series.generate(
            seriesLength,
            statistics.distributions.normal, 1, 1
        )
		expect(statistics.series.mean(standardNormalSeries)).to.be.near(1)
		expect(statistics.series.standardDeviation(standardNormalSeries)).to.be.near(1)
	end)
end