# Install — VS Code + GitHub Copilot

**Audience:** Engineers and platform teams deploying token-saving defaults across service repositories.

**Stack:** Visual Studio Code **1.120+**, GitHub Copilot extension (Business or Enterprise), Usage-Based Billing with pooled GitHub AI Credits.

This kit has nothing to do with other AI IDEs. Every path below is for **GitHub Copilot in VS Code**.

---

## Quick start (5 minutes)

Copy **two files** into each project:

| From this repo | To your project |
|----------------|-----------------|
| [`.github/copilot-instructions.md`](.github/copilot-instructions.md) | `.github/copilot-instructions.md` |
| [`.copilotignore`](.copilotignore) | `.copilotignore` (repo root) |

```bash
REPO=/path/to/your-service-repo

mkdir -p "$REPO/.github"
cp .github/copilot-instructions.md "$REPO/.github/copilot-instructions.md"
cp .copilotignore "$REPO/.copilotignore"
```

Open the project in VS Code. Copilot Chat loads `.github/copilot-instructions.md` automatically as a **stable prefix** — your architecture rules, file budget, and model guidance apply on every turn without re-pasting them into chat.

---

## What you get

| File | Role |
|------|------|
| `.github/copilot-instructions.md` | Repo-wide system instructions — FinOps, context limits, cache habits, Azure NorthStar defaults, Scope-Down checklist |
| `.copilotignore` | Excludes `node_modules/`, `dist/`, lockfiles, logs, and build artifacts from Copilot context |

**Why two files matter under UBB:** Re-pasting standards every chat turn bills as **fresh input**. Instructions in `.github/copilot-instructions.md` load once per session and reuse across turns at **cached-input** rates when the prefix stays stable. `.copilotignore` stops accidental attachment of vendor trees and build output — the most common source of token bleed.

---

## Customize (before wide rollout)

Edit `.github/copilot-instructions.md` in each service repo:

1. **Azure NorthStar** — replace APIM, Service Bus, Key Vault, and naming rows with your landing-zone standards.
2. **Model tiers** — update S/M/L model names when GitHub publishes new models ([Models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing)).
3. **Compliance** — align refusal language with your security team (PII, secrets, production data).

Optional — path-specific rules for part of the codebase:

```text
.github/instructions/
  api.instructions.md       # front matter: applyTo: "**/Controllers/**"
  workers.instructions.md   # applyTo: "**/Workers/**"
```

Keep repo-wide rules in `copilot-instructions.md`; use `.github/instructions/*.instructions.md` only when a folder needs extra guidance.

---

## Verify in VS Code

After copying into a pilot repo:

- [ ] Open the repo in VS Code 1.120+ with Copilot signed in.
- [ ] Open Copilot Chat — confirm repo instructions are active (Copilot settings or usage panel).
- [ ] Confirm `.copilotignore` is at the **repo root** and excludes `node_modules/`, `dist/`, lockfiles.
- [ ] Run a smoke test: short prompt + one `#file` — no standards preamble in chat.
- [ ] Link your team wiki or PR template to the **Scope-Down checklist** in `copilot-instructions.md`.
- [ ] One engineer runs [Exercise 1](examples/cache_friendly_patterns/01_stable_system_prefix.md) Before vs After and compares credit drawdown.

---

## How to prompt after install

| Do | Don't |
|----|-------|
| Short task text + `#file` (≤3 files) | Re-paste architecture standards each turn |
| Active selection for single-function debug | `@workspace` for vague tasks ("fix the app") |
| Continue the same chat when files are unchanged | Attach lockfiles, `dist/`, or full CI logs |
| Inline completions / NES for small edits (free) | Use Chat for keystroke-level changes |
| Reference "per repo instructions" | Paste 400+ tokens of policy before every ask |

**Example — wasteful:**

> We use APIM, Service Bus, App Insights, managed identity, Key Vault, Polly, correlation IDs, xUnit, Bicep… Add a refund handler.

**Example — clean:**

> Add `RefundRequested` Service Bus handler per repo instructions. `#file src/Orders.Worker/Handlers/`

Prompt conventions: `#file path` (default), active selection (debug), model tier S/M/L when choosing models, standards always in `copilot-instructions.md` never in chat.

---

## Optional: training labs in service repos

To embed Before/After exercises locally (onboarding, lunch-and-learns):

```bash
REPO=/path/to/your-service-repo

mkdir -p "$REPO/examples/token-saver"
cp -R examples/. "$REPO/examples/token-saver/"
```

Point engineers to `examples/token-saver/README.md`. Labs are **not required** for Copilot to follow the rules — only `copilot-instructions.md` + `.copilotignore` are.

To add your own exercise: copy [`templates/exercise-template.md`](templates/exercise-template.md), fill in Before/After sections, and index it in the folder README.

---

## Platform team rollout

| Week | Action |
|------|--------|
| 1 | Publish this repo internally; confirm VS Code and Copilot extension versions |
| 2 | Deploy the two-file drop-in to pilot service repos |
| 3 | Lunch-and-learn using [examples/](examples/) labs |
| 4 | Set user budgets for agent-heavy teams; enable billing alerts at 70% / 90% |
| 5 | Retro: credits consumed vs stories closed; tune model policy |

Full UBB economics, admin budgets, and governance: [README.md](README.md).

---

## Repository layout

```text
GitHub_Tokensaver/
├── INSTALL.md                          ← start here (this file)
├── README.md                           ← full curriculum and FinOps reference
├── .github/copilot-instructions.md     ← copy to every service repo
├── .copilotignore                      ← copy to every service repo
├── templates/exercise-template.md      ← optional: add team-specific labs
└── examples/                           ← optional: hands-on Before/After training
    ├── cache_friendly_patterns/
    └── token_bleed_anti_patterns/
```
