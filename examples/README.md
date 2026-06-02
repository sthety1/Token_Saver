# Examples: Hands-On FinOps Exercises

This directory contains runnable and copy-paste exercises for enterprise engineering teams learning GitHub Copilot under **Usage-Based Billing (UBB)** with pooled GitHub AI Credits.

## Portable copy

To install token-saving defaults in another repo, start with [INSTALL.md](../INSTALL.md) — minimum drop-in is `.github/copilot-instructions.md` + `.copilotignore`.

## Prerequisites

- Copilot Business or Enterprise license assigned to your org
- VS Code **1.120+** (or equivalent minimum versions in the [Master Guide](../README.md#ide-client-and-extension-minimum-versions))
- Usage panel visible in your IDE (credits consumed per interaction)
- Read [`.github/copilot-instructions.md`](../.github/copilot-instructions.md) — it models the **stable system prefix** you should use in real repos

## Directory map

| Path | Focus |
|------|--------|
| [`cache_friendly_patterns/`](cache_friendly_patterns/) | Maximize prompt cache-hit ratio and context window stability |
| [`token_bleed_anti_patterns/`](token_bleed_anti_patterns/) | Side-by-side prompts that waste pooled credits or violate governance |

## How to run an exercise

1. Open the example file in VS Code with Copilot Chat.
2. Execute the **Before** prompt in a **new** chat thread; note credits consumed (or relative usage indicator).
3. Execute the **After** prompt using the prescribed context modifiers (`#file`, selection, model tier).
4. Compare credit drawdown and response latency.
5. Discuss with your team: *What would this cost at 500 engineers × 20 sessions/day?*

## Fictional domain

All code samples use **Contoso.Retail** — a synthetic e-commerce platform. No production data, customer PII, or live secrets appear in this repository.

## Uniform exercise format

Every exercise follows the same markdown structure (see [`templates/exercise-template.md`](../templates/exercise-template.md)):

```markdown
> **Category:** `cache-friendly` | `token-bleed`
> **Skill:** …
> **Supporting files:** …

## Scenario

### Before (Token Wasteful / Non-Compliant)
### After (FinOps Clean / Enterprise Compliant)

**Why:** …
**Credit tier:** Before = **…** | After = **…**
**Compliance:** Pass | Fail | Risk
```

## Next steps

- Complete all exercises in `cache_friendly_patterns/` before `token_bleed_anti_patterns/`.
- Copy [`.github/copilot-instructions.md`](../.github/copilot-instructions.md) and [`templates/.copilotignore`](../templates/.copilotignore) into your team's service repositories; customize Azure NorthStar names to match your landing zone.
- Return to the [Master Enterprise Guide](../README.md) for policy rollout and admin budget configuration.
