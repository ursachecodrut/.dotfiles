local parse = require("present")._parse_slides

describe("present.parse_slides", function()
	it("should parse an empty file", function()
		assert.are.same({
			slides = {
				{

					title = "",
					body = {},
				},
			},
		}, parse({}))
	end)
end)
