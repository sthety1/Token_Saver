# GitHub Tokensaver

Drop-in defaults for **GitHub Copilot in VS Code** under usage-based billing (pooled GitHub AI Credits). Clone this repo, copy two files into each service repository, customize once, and stop re-pasting architecture standards in every chat turn.

| File | Copy to your service repo |
|------|---------------------------|
| [`.github/copilot-instructions.md`](.github/copilot-instructions.md) | `.github/copilot-instructions.md` |
| [`.copilotignore`](.copilotignore) | `.copilotignore` (repo root) |

**Install guide:** [INSTALL.md](INSTALL.md) — quick start, customization, verification checklist, and prompt habits.

**Last verified:** June 2026. Confirm billing and models against [GitHub Docs — models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing).

---

## Why two files

| File | What it does |
|------|----------------|
| `copilot-instructions.md` | Stable repo-wide prefix — FinOps, context limits, cache habits, Azure NorthStar defaults, Scope-Down checklist |
| `.copilotignore` | Keeps `node_modules/`, `dist/`, lockfiles, and build artifacts out of Copilot context |

Re-pasting standards every turn bills as **fresh input**. Instructions in `copilot-instructions.md` load once per session and reuse at **cached-input** rates when the prefix stays stable.

---

## Quick start

```bash
git clone <your-org>/GitHub_Tokensaver.git
cd GitHub_Tokensaver

REPO=/path/to/your-service-repo
mkdir -p "$REPO/.github"
cp .github/copilot-instructions.md "$REPO/.github/copilot-instructions.md"
cp .copilotignore "$REPO/.copilotignore"
```

Open the service repo in VS Code 1.120+ with Copilot signed in. Edit `copilot-instructions.md` for your landing zone (APIM, Service Bus, Key Vault, naming) before wide rollout.

---

## Prompt cheat sheet

```text
FREE:      Inline completions, next edit suggestions
CHEAP:     Small model + ≤3 #file + same chat thread
EXPENSIVE: @workspace, full logs, lockfiles/dist, frontier models, new threads with huge attachments
CACHE:     Stable copilot-instructions, append-at-EOF edits, same #file set across turns
COMPLY:    No PII or production data — synthetic repro only
```

| Do | Don't |
|----|-------|
| Short task + `#file` (≤3 files) | Re-paste architecture standards each turn |
| Active selection for one-function debug | `@workspace` for vague tasks |
| Continue the same chat when files are unchanged | Attach lockfiles, `dist/`, or full CI logs |
| Inline completions for small edits | Use Chat for keystroke-level changes |

**Clean prompt example:** Add `RefundRequested` Service Bus handler per repo instructions. `#file src/Orders.Worker/Handlers/`

---

## Credits at a glance

Under UBB (June 2026+), billable Copilot features draw from a **pooled** org credit balance (1 credit = $0.01 USD). Inline completions do **not** consume credits.

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
├── .github/copilot-instructions.md
└── .copilotignore
```

---

## License and maintenance

Internal enterprise training kit. Verify billing numbers quarterly against GitHub Docs. Update model names in `copilot-instructions.md` when GitHub publishes changes.
