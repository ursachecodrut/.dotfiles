return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	config = function()
		local home = os.getenv("HOME")
		local jdtls_dir = home .. "/.local/share/nvim/mason/packages/jdtls/"
		local config_dir = jdtls_dir .. "config_mac_arm/"
		local plugins_dir = jdtls_dir .. "plugins/"
		local jar_file = plugins_dir .. "org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
		local lombok_jar = jdtls_dir .. "lombok.jar"

		local root_markers = { ".git", "pom.xml", "gradlew", "build.gradle", "settings.gradle", "mvnw" }
		local root_dir = require("jdtls.setup").find_root(root_markers)
		local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

		print("JDTLS Directory: " .. jdtls_dir)
		print("Config Directory: " .. config_dir)
		print("Plugins Directory: " .. plugins_dir)
		print("JAR File: " .. jar_file)
		print("Lombok JAR: " .. lombok_jar)

		print("Root Directory: " .. root_dir)

		local config = {
			cmd = {
				"java",

				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xms1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-javaagent:" .. lombok_jar,
				"-jar",
				jar_file,
				"-configuration",
				config_dir,
				"-data",
				workspace_dir,
			},
			root_dir = root_dir,
			settings = {
				java = {
					home = os.getenv("JAVA_HOME"),
					eclipse = {
						downloadSources = true,
					},
					configuration = {
						updateBuildConfiguration = "interactive",
						runtimes = {
							{
								name = "JavaSE-17", -- Adjust version as needed
								path = os.getenv("JAVA_HOME"),
							},
						},
					},
					maven = {
						downloadSources = true,
					},
					implementationsCodeLens = {
						enabled = true,
					},
					referencesCodeLens = {
						enabled = true,
					},
					references = {
						includeDecompiledSources = true,
					},
					format = {
						enabled = true,
						settings = {
							url = home .. "/.local/share/eclipse/eclipse-java-google-style.xml",
							profile = "GoogleStyle",
						},
					},
				},
				completion = {
					favoriteStaticMembers = {
						"org.hamcrest.MatcherAssert.assertThat",
						"org.hamcrest.Matchers.*",
						"org.junit.Assert.*",
						"org.junit.Assume.*",
						"org.junit.jupiter.api.Assertions.*",
						"org.junit.jupiter.api.Assumptions.*",
						"org.junit.jupiter.api.DynamicContainer.*",
						"org.junit.jupiter.api.DynamicTest.*",
					},
				},
				contentProvider = {
					preferred = "fernflower",
				},
				extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					useBlocks = true,
				},
			},
			flags = {
				allow_incremental_sync = true,
			},
			init_options = {
				bundles = {},
			},
		}

		local bufopts = { noremap = true, silent = true }

		-- Java specific
		vim.keymap.set("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", bufopts)
		vim.keymap.set("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", bufopts)
		vim.keymap.set("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", bufopts)
		vim.keymap.set("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", bufopts)
		vim.keymap.set("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", bufopts)
		vim.keymap.set("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", bufopts)

		require("jdtls").start_or_attach(config)
	end,
}
