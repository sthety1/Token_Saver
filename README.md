# GitHub Tokensaver

Drop-in defaults for **GitHub Copilot in VS Code** under usage-based billing (pooled GitHub AI Credits). Clone this repo, copy the kit into each service repository, customize once, and stop re-pasting architecture standards in every chat turn.

| Copy from | To your service repo |
|-----------|----------------------|
| [`.github/copilot-instructions.md`](.github/copilot-instructions.md) | `.github/copilot-instructions.md` |
| [`.github/instructions/`](.github/instructions/) | `.github/instructions/` (optional path-scoped rules) |
| [`.copilotignore`](.copilotignore) | `.copilotignore` (repo root) |

**Install guide:** [INSTALL.md](INSTALL.md) — quick start, customization, verification checklist, and prompt habits.

**Last verified:** June 2026. Confirm billing and models against [GitHub Docs — models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing).

---

## Why this kit

| File | What it does |
|------|----------------|
| `copilot-instructions.md` | Lean repo-wide prefix — FinOps, context, cache, output discipline, Scope-Down (<4k chars for PR code review) |
| `.github/instructions/*.instructions.md` | Path-scoped Azure NorthStar and TDD rules — load only when `applyTo` matches |
| `.copilotignore` | Keeps vendor trees, build output, and test fixtures out of Copilot context |

Re-pasting standards every turn bills as **fresh input**. Instructions in `copilot-instructions.md` load once per session and reuse at **cached-input** rates when the prefix stays stable (cached tokens still bill, at lower rates).

---

## Quick start

```bash
git clone <your-org>/GitHub_Tokensaver.git
cd GitHub_Tokensaver

REPO=/path/to/your-service-repo
mkdir -p "$REPO/.github/instructions"
cp .github/copilot-instructions.md "$REPO/.github/copilot-instructions.md"
cp .github/instructions/*.instructions.md "$REPO/.github/instructions/"
cp .copilotignore "$REPO/.copilotignore"
```

Open the service repo in VS Code 1.120+ with Copilot signed in. Edit `azure-northstar.instructions.md` for your landing zone before wide rollout.

---

## Prompt cheat sheet

```text
FREE:      Inline completions, next edit suggestions
CHEAP:     S-tier model (GPT-5 mini / nano) + ≤3 #file + same thread + patch-only replies
EXPENSIVE: @workspace, Agent for one-shot edits, GPT-5.3-Codex default, Opus/GPT-5.5, full logs
OUTPUT:    Diffs beat essays — output tokens cost more than input
CACHE:     Stable copilot-instructions, append-at-EOF, same #file set; no model switch mid-thread
COMPLY:    No PII or production data — synthetic repro only
```

| Do | Don't |
|----|-------|
| Short task + `#file` (≤3 files) | Re-paste architecture standards each turn |
| Ask/Edit for single-file work | Agent mode for keystroke-level or one-shot fixes |
| Active selection for one-function debug | `@workspace` for vague tasks |
| Continue the same chat when files are unchanged | Attach lockfiles, `dist/`, or full CI logs |
| Inline completions for small edits | Sonnet/Opus for rename-level tasks |
| GPT-5 mini / GPT-5.4 nano for S-tier | Leave default Codex on for routine Chat |

**Clean prompt example:** Add `RefundRequested` Service Bus handler per repo instructions. `#file src/Orders.Worker/Handlers/`

---

## Model tiers (Enterprise UBB)

| Tier | Use for | Prefer |
|------|---------|--------|
| S | Syntax, rename, doc tweak | GPT-5 mini, GPT-5.4 nano, Raptor mini, Haiku 4.5 |
| M | ≤3 files, API contract | GPT-5.4 mini, Haiku 4.5, GPT-5 mini |
| L | Architecture, agent workflows | GPT-5.3-Codex, GPT-5.4, Sonnet; Opus/GPT-5.5 with approval |

Org default **GPT-5.3-Codex** is powerful-tier pricing — downshift for daily Chat.

---

## Credits at a glance

Under UBB (June 2026+), billable Copilot features draw from a **pooled** org credit balance (1 credit = $0.01 USD). Inline completions do **not** consume credits. PR code review consumes **credits and GitHub Actions minutes**.

| Plan | Standard credits / user / month |
|------|----------------------------------|
| Copilot Business | 1,900 |
| Copilot Enterprise | 3,900 |

Promotional uplift for existing customers through **September 1, 2026:** Business 3,000 / Enterprise 7,000 per user per month. Details: [Usage-based billing](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises).

---

## Repository layout

```text
GitHub_Tokensaver/
├── INSTALL.md
├── README.md
├── .github/
│   ├── copilot-instructions.md
│   └── instructions/
│       ├── azure-northstar.instructions.md
│       └── tests.instructions.md
└── .copilotignore
```

---

## License and maintenance

Internal enterprise training kit. Verify billing numbers quarterly against GitHub Docs. Update model names in `copilot-instructions.md` when GitHub publishes changes.
