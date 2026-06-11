return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local rep = require("luasnip.extras").rep
    local fmt = require("luasnip.extras.fmt").fmt

    ls.setup({
      history = true,
      region_check_events = "InsertEnter",
      delete_check_events = "TextChanged",
    })

    -- ─── Elixir ───────────────────────────────────────────────────────────────

    ls.add_snippets("elixir", {
      -- defmodule
      s("mod", fmt([[
        defmodule {} do
          {}
        end
      ]], { i(1, "ModuleName"), i(2) })),

      -- def
      s("def", fmt([[
        def {}({}) do
          {}
        end
      ]], { i(1, "name"), i(2), i(3) })),

      -- defp
      s("defp", fmt([[
        defp {}({}) do
          {}
        end
      ]], { i(1, "name"), i(2), i(3) })),

      -- @doc
      s("doc", fmt([[
        @doc """
        {}
        """
      ]], { i(1, "Description.") })),

      -- @moduledoc
      s("mdoc", fmt([[
        @moduledoc """
        {}
        """
      ]], { i(1, "Description.") })),

      -- @spec
      s("spec", fmt([[
        @spec {}({}) :: {}
      ]], { i(1, "name"), i(2, "arg :: type"), i(3, "return_type") })),

      -- @type
      s("typ", fmt([[
        @type {} :: {}
      ]], { i(1, "name"), i(2, "type") })),

      -- case
      s("case", fmt([[
        case {} do
          {} -> {}
          _ -> {}
        end
      ]], { i(1, "expr"), i(2, "pattern"), i(3), i(4) })),

      -- cond
      s("cond", fmt([[
        cond do
          {} -> {}
          true -> {}
        end
      ]], { i(1, "condition"), i(2), i(3) })),

      -- with
      s("with", fmt([[
        with {{:ok, {}}} <- {},
             {{:ok, {}}} <- {} do
          {}
        else
          {{:error, reason}} -> {}
        end
      ]], { i(1, "val1"), i(2), i(3, "val2"), i(4), i(5), i(6) })),

      -- if/else
      s("ife", fmt([[
        if {} do
          {}
        else
          {}
        end
      ]], { i(1, "condition"), i(2), i(3) })),

      -- IO.inspect (various forms)
      s("ii",   { t("IO.inspect("), i(1), t(")") }),
      s("iil",  { t("IO.inspect("), i(1), t(", label: \""), i(2), t("\")") }),
      s("iip",  { t("|> IO.inspect()") }),
      s("iipl", { t("|> IO.inspect(label: \""), i(1), t("\")") }),
      s("dbg",  { t("dbg("), i(1), t(")") }),
      s("dbgp", { t("|> dbg()") }),

      -- ExUnit test
      s("test", fmt([[
        test "{}" do
          {}
        end
      ]], { i(1, "description"), i(2) })),

      -- ExUnit describe
      s("desc", fmt([[
        describe "{}" do
          {}
        end
      ]], { i(1, "context"), i(2) })),

      -- ExUnit setup
      s("setup", fmt([[
        setup do
          {}
          :ok
        end
      ]], { i(1) })),

      -- GenServer boilerplate
      s("genserver", fmt([[
        defmodule {} do
          use GenServer

          def start_link(opts \\ []) do
            GenServer.start_link(__MODULE__, opts, name: __MODULE__)
          end

          @impl true
          def init(state) do
            {{:ok, state}}
          end

          @impl true
          def handle_call({}, _from, state) do
            {{:reply, {}, state}}
          end

          @impl true
          def handle_cast({}, state) do
            {{:noreply, state}}
          end

          @impl true
          def handle_info({}, state) do
            {{:noreply, state}}
          end
        end
      ]], { i(1, "MyServer"), i(2, ":request"), i(3, ":ok"), i(4, ":msg"), i(5, ":info") })),

      -- handle_call
      s("hcall", fmt([[
        @impl true
        def handle_call({}, _from, state) do
          {{:reply, {}, state}}
        end
      ]], { i(1, ":request"), i(2, ":ok") })),

      -- handle_cast
      s("hcast", fmt([[
        @impl true
        def handle_cast({}, state) do
          {{:noreply, state}}
        end
      ]], { i(1, ":msg") })),

      -- handle_info
      s("hinfo", fmt([[
        @impl true
        def handle_info({}, state) do
          {{:noreply, state}}
        end
      ]], { i(1, ":info") })),

      -- Logger
      s("log", fmt([[
        require Logger
        Logger.{}("{}")
      ]], { i(1, "debug"), i(2, "message") })),

      -- pipe chain
      s("pipe", fmt([[
        {}
        |> {}
      ]], { i(1, "value"), i(2) })),

      -- ~H sigil block
      s("heex", {
        t({ '~H"""', "" }),
        i(1),
        t({ "", '"""' }),
      }),

      -- LiveView / HEEx inline (for ~H sigils in .ex files)
      s("ee",     { t("{"), i(1), t("}") }),
      s("ea",     { t("{@"), i(1), t("}") }),
      s("eex",    { t("<%= "), i(1), t(" %>") }),
      s("eif",    { t(":if={"), i(1), t("}") }),
      s("efor",   { t(":for={"), i(1), t(" <- "), i(2), t("}") }),
      s("ec",     { t("<."), i(1), t(" />") }),
      s("ecb",    { t("<."), i(1), t(">"), i(2), t("</."), i(3), t(">") }),
      s("fcc",    { t("<."), i(1, "component"), t(">"), i(2), t("</."), rep(1), t(">") }),
      s("sl",     { t("<:"), i(1, "slot"), t(">"), i(2), t("</:"), rep(1), t(">") }),
      s("elink",  { t('<.link navigate={~p"'), i(1), t('"}>'), i(2), t("</.link>") }),
      s("eform",  { t("<.form for={"), i(1, "@form"), t('} phx-submit="'), i(2), t('">'), i(3), t("</.form>") }),
      s("einput", { t("<.input field={"), i(1, "@form[:field]"), t('} type="'), i(2, "text"), t('" label="'), i(3), t('" />') }),
      s("ebtn",   { t('<.button phx-click="'), i(1), t('">'), i(2), t("</.button>") }),
      s("pc",     { t('phx-click="'), i(1), t('"') }),
      s("pch",    { t('phx-change="'), i(1), t('"') }),
      s("ps",     { t('phx-submit="'), i(1), t('"') }),
      s("pv",     { t("phx-value-"), i(1), t("={"), i(2), t("}") }),

      -- LiveView mount/render/handle_event boilerplate
      s("lv", fmt([[
        defmodule {}Web.{} do
          use {}Web, :live_view

          @impl true
          def mount(_params, _session, socket) do
            {{:ok, socket}}
          end

          @impl true
          def render(assigns) do
            ~H"""
            {}
            """
          end
        end
      ]], { i(1, "App"), i(2, "PageLive"), i(3, "App"), i(4) })),

      -- handle_event
      s("hev", fmt([[
        @impl true
        def handle_event("{}", params, socket) do
          {{:noreply, socket}}
        end
      ]], { i(1, "event_name") })),

      -- handle_params
      s("hpar", fmt([[
        @impl true
        def handle_params({}, _uri, socket) do
          {{:noreply, socket}}
        end
      ]], { i(1, "params") })),

      -- assign
      s("asgn", { t("assign(socket, "), i(1), t(": "), i(2), t(")") }),
      s("asgnu", { t("assign(socket, Map.from_struct("), i(1), t("))") }),

      -- push_navigate / push_patch
      s("pnav",   { t('push_navigate(socket, to: ~p"'), i(1), t('")') }),
      s("ppatch", { t('push_patch(socket, to: ~p"'), i(1), t('")') }),
    })

    -- ─── HEEx ─────────────────────────────────────────────────────────────────

    ls.add_snippets("heex", {
      s("ee",     { t("{"), i(1), t("}") }),
      s("ea",     { t("{@"), i(1), t("}") }),
      s("eex",    { t("<%= "), i(1), t(" %>") }),
      s("ex",     { t("<% "), i(1), t(" %>") }),
      s("eif",    { t(":if={"), i(1), t("}") }),
      s("efor",   { t(":for={"), i(1), t(" <- "), i(2), t("}") }),
      s("ec",     { t("<."), i(1), t(" />") }),
      s("ecb",    { t("<."), i(1), t(">"), i(2), t("</."), i(3), t(">") }),
      s("fcc",    { t("<."), i(1, "component"), t(">"), i(2), t("</."), rep(1), t(">") }),
      s("sl",     { t("<:"), i(1, "slot"), t(">"), i(2), t("</:"), rep(1), t(">") }),
      s("elink",  { t('<.link navigate={~p"'), i(1), t('"}>'), i(2), t("</.link>") }),
      s("eform",  { t("<.form for={"), i(1, "@form"), t('} phx-submit="'), i(2), t('">'), i(3), t("</.form>") }),
      s("einput", { t("<.input field={"), i(1, "@form[:field]"), t('} type="'), i(2, "text"), t('" label="'), i(3), t('" />') }),
      s("ebtn",   { t('<.button phx-click="'), i(1), t('">'), i(2), t("</.button>") }),
      s("pc",     { t('phx-click="'), i(1), t('"') }),
      s("pch",    { t('phx-change="'), i(1), t('"') }),
      s("ps",     { t('phx-submit="'), i(1), t('"') }),
      s("pv",     { t("phx-value-"), i(1), t("={"), i(2), t("}") }),
    })
  end,
}
