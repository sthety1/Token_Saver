# Install — VS Code + GitHub Copilot

**Audience:** Engineers and platform teams deploying token-saving defaults across service repositories.

**Stack:** Visual Studio Code **1.120+**, GitHub Copilot extension (Business or Enterprise), Usage-Based Billing with pooled GitHub AI Credits.

This kit is for **GitHub Copilot in VS Code** only.

---

## Quick start (5 minutes)

Copy into each project:

| From this repo | To your project |
|----------------|-----------------|
| [`.github/copilot-instructions.md`](.github/copilot-instructions.md) | `.github/copilot-instructions.md` |
| [`.github/instructions/`](.github/instructions/) | `.github/instructions/` |
| [`.copilotignore`](.copilotignore) | `.copilotignore` (repo root) |

```bash
REPO=/path/to/your-service-repo

mkdir -p "$REPO/.github/instructions"
cp .github/copilot-instructions.md "$REPO/.github/copilot-instructions.md"
cp .github/instructions/*.instructions.md "$REPO/.github/instructions/"
cp .copilotignore "$REPO/.copilotignore"
```

Open the project in VS Code. Copilot loads `.github/copilot-instructions.md` as a **stable prefix** on every turn. Path-scoped files apply only when `applyTo` matches the file you are editing.

---

## What you get

| File | Role |
|------|------|
| `.github/copilot-instructions.md` | Lean repo-wide FinOps, context, output discipline, cache, compliance (~2.8k chars — full file visible to PR code review) |
| `.github/instructions/*.instructions.md` | Azure NorthStar and TDD rules — billed only when globs match |
| `.copilotignore` | Excludes vendor trees, build artifacts, `.git/`, packages, snapshots, and large fixtures |

**Why it matters under UBB:** Re-pasting standards every chat turn bills as **fresh input**. The repo-wide file reuses at **cached-input** rates when the prefix stays stable. Shrinking always-on instructions saves credits on every Chat and agent step.

---

## Customize (before wide rollout)

1. **Azure NorthStar** — edit [`.github/instructions/azure-northstar.instructions.md`](.github/instructions/azure-northstar.instructions.md) (APIM, Service Bus, Key Vault, naming).
2. **Model tiers** — edit S/M/L names in `copilot-instructions.md` when GitHub updates [models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing).
3. **Compliance** — align refusal language with your security team.
4. **Org dedup** — if enterprise Copilot instructions already cover compliance or Azure, trim repo-wide file to FinOps and context only.

Add more path rules only when needed — **matching** `*.instructions.md` files **stack** (union), which increases input tokens:

```text
.github/instructions/
  azure-northstar.instructions.md   # applyTo: "**/*.{cs,bicep,tf}"
  tests.instructions.md             # applyTo: "**/*Tests/**,**/*.Tests/**"
  api.instructions.md               # optional: "**/Controllers/**"
```

Avoid overlapping globs that load duplicate guidance.

---

## Verify in VS Code

After copying into a pilot repo:

- [ ] VS Code 1.120+ with Copilot signed in
- [ ] Copilot Chat — repo instructions active (usage panel or References on a reply)
- [ ] `.copilotignore` at repo root
- [ ] Open a `.cs` file — References include `azure-northstar.instructions.md` when applicable
- [ ] Smoke test: short prompt + one `#file` — no standards preamble in chat
- [ ] `wc -c .github/copilot-instructions.md` — keep under **4,000** for PR code review coverage

---

## How to prompt after install

| Do | Don't |
|----|-------|
| Short task + `#file` (≤3 files) | Re-paste architecture standards each turn |
| Ask/Edit for single-file changes | Agent for one-shot or keystroke edits |
| GPT-5 mini / nano for S-tier tasks | Leave GPT-5.3-Codex default on for routine work |
| Active selection for one-function debug | `@workspace` for vague tasks |
| Continue chat when files unchanged | Attach lockfiles, `dist/`, or full CI logs |
| Inline completions / NES (free) | Long Chat replies when a diff suffices |
| Reference "per repo instructions" | Paste policy blocks before every ask |

**Example — wasteful:**

> We use APIM, Service Bus, App Insights… Add a refund handler. (Agent mode, Sonnet, @workspace)

**Example — clean:**

> Add `RefundRequested` Service Bus handler per repo instructions. `#file src/Orders.Worker/Handlers/` (GPT-5 mini, Ask)

---

## Platform team rollout

| Week | Action |
|------|--------|
| 1 | Publish kit; confirm VS Code and Copilot versions |
| 2 | Deploy to pilot repos (three paths: instructions + ignore) |
| 3 | Share [README.md](README.md) cheat sheet; train downshift off Codex default |
| 4 | User budgets for agent-heavy teams; pool alerts at 70% / 90% |
| 5 | Retro: credits vs stories; tune `applyTo` globs to avoid stack bloat |

Billing overview: [README.md](README.md).

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
