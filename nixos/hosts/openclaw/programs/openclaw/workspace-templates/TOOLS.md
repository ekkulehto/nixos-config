# TOOLS.md

- Web research should use SearXNG when available (via the `searxng_search` skill).
- Main agent must NOT browse the web directly. If web research is needed, spawn a sub-agent run targeting the `research` agent via `sessions_spawn` and ask it to use SearXNG.
- Research agent should prefer `searxng_search "<query>"` for searching. Use `web_fetch` only to fetch/inspect specific URLs after search results.
- Never use exec/runtime unless the agent is allowed by tool policy and exec approvals/allowlists.
- If something is blocked, explain what’s blocked and why (tool policy, exec allowlist, network allow/deny).
