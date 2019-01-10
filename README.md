Lua Statistics
===

<div align="center">
	<a href="https://travis-ci.org/noahwillcrow/lua-statistics">
		<img src="https://api.travis-ci.org/noahwillcrow/lua-statistics.svg?branch=master" alt="Travis-CI Build Status" />
	</a>
</div>

A simple script to implement statistical functions not provided by the Lua standard API, developed especially for use on Roblox

Documentation
---

### Series Functions

<details>
<summary><code>statistics.series.sum = function (series)</code></summary>

Given a series of numbers, this will calculate the sum

**Parameters:**
- `series` (`array<number>`)  
An array of numbers

**Returns:**  
`number`  
A number

</details>

<details>
<summary><code>statistics.series.mean = function (series)</code></summary>

Given a series of numbers, this will calculate the mean

**Parameters:**
- `series` (`array<number>`)  
An array of numbers

**Returns:**  
`number`  
A number

</details>

<details>
<summary><code>statistics.series.median = function (series)</code></summary>

Given a series of numbers, this will find the median

**Parameters:**
- `series` (`array<number>`)  
An array of numbers

**Returns:**  
`number`  
A number

**Complexity analysis:**
- Time: O(n lg(n))
- Memory: O(n)


</details>

<details>
<summary><code>statistics.series.mode = function (series)</code></summary>

Given a series of values, this will find the mode
If there is a tie, then all the values that tied will be returned as a sorted array.
Note that this function will work regardless of data type; The data types just need to be sortable in some way and have a method of equality

**Parameters:**
- `series` (`array<any>`)  
An array of values

**Returns:**  
`any`  
If there was a tie, then a sorted array; otherwise a number

**Complexity analysis:**
- Time: O(n lg(n))
- Memory: O(n)


</details>

<details>
<summary><code>statistics.series.variance = function (series)</code></summary>

Given a series of numbers, this will find the variance

**Parameters:**
- `series` (`array<number>`)  
An array of numbers

**Returns:**  
`number`  
A number

</details>

<details>
<summary><code>statistics.series.standardDeviation = function (series)</code></summary>

Given a series of numbers, this will find the standard deviation

**Parameters:**
- `series` (`array<number>`)  
An array of numbers

**Returns:**  
`number`  
A number

</details>

<details>
<summary><code>statistics.series.getExtremes = function (series)</code></summary>

Given a series of numbers, this will find the minimum and maximum values

**Parameters:**
- `series` (`array<number>`)  
An array of numbers

**Returns:**  
[t:tuple<number, number>] The minimum and maximum values as a tuple: <min, max>

</details>

<details>
<summary><code>statistics.series.generate = function (seriesLength, samplingFunction, ...)</code></summary>

Generates a series of numbers pulled from a particular sampling distribution

**Parameters:**
- `seriesLength` (`number`)  
The length of the series to generate
- `samplingFunction` (`function`)  
The sampling function to use
- `...` (`any`)  
Any arguments needed for the sampling function

**Returns:**  
`array<number>`  
An array of numbers

</details>

### Distribution Functions
#### Continuous Distributions

<details>
<summary><code>statistics.distributions.standardNormal = function ()</code></summary>

Samples from a standard normal distribution (mean = 0, variance = 1)
Implementation is based on the Box-Muller (1958) transformation

**Returns:**  
`number`  
A number sampled from the defined distribution

</details>

<details>
<summary><code>statistics.distributions.normal = function (mean, variance)</code></summary>

Samples from a normal distribution with a given mean and variance

**Parameters:**
- `mean` (`number`)  
The mean for the distribution
- `variance` (`number`)  
The variance for the distribution

**Returns:**  
`number`  
A number sampled from the defined distribution

</details>

<details>
<summary><code>statistics.distributions.exponential = function (rate)</code></summary>

Samples from an exponential distribution with a given rate

**Parameters:**
- `rate` (`number`)  
The rate for the distribution

**Returns:**  
`number`  
A number sampled from the defined distribution

</details>

#### Discrete Distributions

<details>
<summary><code>statistics.distributions.bernoulli = function (successProbability)</code></summary>

Samples from a bernoulli distribution with given probability

**Parameters:**
- `successProbability` (`number`)  
The probability of obtaining a 1

**Returns:**  
`number`  
A 0 or a 1, according to the distribution

</details>

<details>
<summary><code>statistics.distributions.binomial = function (numberOfTrials, successProbability)</code></summary>

Samples from a binomial distribution with given probability and number of trials

**Parameters:**
- `numberOfTrials` (`number`)  
The number of trials for the distribution
- `successProbability` (`number`)  
The probability of a success on any given trial

**Returns:**  
`number`  
A non-negative integer in the range [0, numberOfTrials], according to the defined distribution

</details>

<details>
<summary><code>statistics.distributions.standardDiscrete = function (distribution, values)</code></summary>

Samples from a given discrete distribution

**Parameters:**
- `distribution` (`array<number>`)  
An array of numbers that should sum to 1
- `values` (`array<any>`)  
An array of values of the same length as distribution

**Returns:**  
`any`  
A value sampled according to the given distribution

</details>

<details>
<summary><code>statistics.distributions.geometric = function (successProbability)</code></summary>

Samples from a geometric distribution with given success probability
Note that this implementation allows for 0

**Parameters:**
- `successProbability` (`number`)  
The success probability parameter for the distribution

**Returns:**  
`number`  
A non-negative integer sampled from the defined distribution

</details>
