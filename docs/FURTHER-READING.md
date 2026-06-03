# Further reading

This kit is an **enterprise drop-in** (FinOps, Azure NorthStar, `.copilotignore`). For a broader, community-maintained optimization guide, see:

- [github-copilot-token-optimization](https://github.com/olivomarco/github-copilot-token-optimization) by Marco Olivo
- Published site: [olivomarco.github.io/github-copilot-token-optimization](https://olivomarco.github.io/github-copilot-token-optimization/)

That guide is **not** official GitHub or Microsoft documentation. Use it alongside [GitHub Docs — Copilot](https://docs.github.com/en/copilot).

## Techniques already reflected in this kit

| Technique | Where in this repo |
|-----------|-------------------|
| Lean always-on `copilot-instructions.md` | `.github/copilot-instructions.md` |
| Path-scoped instructions (`applyTo`) | `.github/instructions/*.instructions.md` |
| Output control (code-only, bullets) | `copilot-instructions.md` → Output |
| Ask before Agent; ≤3 `#file` | `copilot-instructions.md` → Context, Modes |
| MCP server audit | `copilot-instructions.md` → MCP & tools |
| Context exclusion | `.copilotignore` |
| Prune `AGENTS.md` | `copilot-instructions.md` → Context |

## High-impact additions from the community guide

Consider adopting these in your org outside this kit:

1. **Weekly MCP audit** — disable servers you did not use that week.
2. **Workspace MCP** — `.vscode/mcp.json` per repo instead of many global servers.
3. **Model prompt retuning** — when changing default models, ask Copilot to adapt instructions using the provider’s prompting guide.
4. **Copilot CLI `/context`** — inspect System/Tools baseline (MCP + instructions) in CLI sessions.
5. **Pool governance** — per-user budgets and model access policy (see guide’s Enterprise Governance chapter).

## Official references

- [Usage-based billing](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises)
- [Models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)
- [Custom instructions](https://docs.github.com/en/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot)
