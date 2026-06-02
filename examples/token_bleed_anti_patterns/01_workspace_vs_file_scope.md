# Anti-Pattern 1: @workspace vs File Scope

> **Category:** `token-bleed`  
> **Skill:** Replace `@workspace` with ≤3 `#file` attachments and a fast model  
> **Supporting files:** none

## Scenario

Bug: JWT validation fails in `Contoso.Retail.Identity` with error `IDX10503` after a config change.

---

### Before (Token Wasteful / Non-Compliant)

> @workspace Our login is broken after the deployment. Find and fix everything related to authentication across all projects. Use Claude Opus 4.7.

**Mechanisms of waste:**

- Workspace index spans Identity, Orders, Payments, mobile clients, IaC, docs
- Frontier model multiplies per-token cost
- Vague "fix everything" invites multi-turn agent expansion

**Credit tier:** **High** (often 100+ credits in large monorepos)

**Compliance:** **Risk** — workspace may surface files with secrets in comments or test fixtures

---

### After (FinOps Clean / Enterprise Compliant)

> #file src/Contoso.Retail.Identity/Auth/JwtBearerConfiguration.cs  
> #file tests/Contoso.Retail.Identity.Tests/JwtValidationTests.cs  
> Model: Claude Haiku 4.5  
> Error `IDX10503` after rotating signing key. Diagnose validation parameters only; propose minimal diff.

**Why:** Two files, fast model, deterministic scope. Inline tests confirm fix without scanning Payments service.

**Credit tier:** Before = **High** | After = **Low–Medium**

**Compliance:** **Pass**

---

## Modifier cheat sheet

| Modifier | Scope | When to use |
|----------|-------|-------------|
| Active selection | Selected lines | Single-function debug |
| `#file path` | One file | Default for implementation |
| `#file` × 2–3 | Bounded feature | Cross-layer change with justification |
| `@workspace` | Repo-wide | **Rare** — architecture audits with lead approval + budget |

## `.copilotignore` starter

```gitignore
node_modules/
dist/
bin/
obj/
*.lock
coverage/
.terraform/
```
