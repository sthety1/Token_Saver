# Portable install — copy into any repository

Use this kit to give every service repo the same **token-saving defaults** without re-reading the full training guide.

## Minimum drop-in (5 minutes)

Copy these files into each project:

| From this repo | To your project |
|----------------|-----------------|
| [`.github/copilot-instructions.md`](.github/copilot-instructions.md) | `.github/copilot-instructions.md` |
| [`templates/.copilotignore`](templates/.copilotignore) | `.copilotignore` (repo root) |

Then customize:

1. Replace Azure NorthStar table rows with your landing-zone names (APIM, Service Bus, Key Vault, etc.).
2. Adjust model tier names when GitHub publishes new models.
3. Add path-specific rules under `.github/instructions/*.instructions.md` if needed.

## Optional: team training examples

Copy the entire [`examples/`](examples/) folder if you want local Before/After labs in the repo:

```bash
cp .github/copilot-instructions.md /path/to/your-repo/.github/
cp templates/.copilotignore /path/to/your-repo/.copilotignore
mkdir -p /path/to/your-repo/examples/token-saver
# Trailing /. copies contents only — avoids examples/token-saver/examples/ nesting
cp -R examples/. /path/to/your-repo/examples/token-saver/
```

Point engineers to `examples/token-saver/README.md` for lab instructions.

## Uniform exercise format

Every exercise in this repo follows the same markdown shape so you can add your own:

1. Copy [`templates/exercise-template.md`](templates/exercise-template.md).
2. Fill in **Category**, **Skill**, **Scenario**, **Before**, **After**, and metadata fields.
3. Place under `examples/token-saver/cache_friendly_patterns/` or `examples/token-saver/token_bleed_anti_patterns/` in your service repo (or the equivalent paths in this training repo).
4. Add a row to that folder's `README.md` index table.

### Required sections (every exercise)

```markdown
### Before (Token Wasteful / Non-Compliant)
### After (FinOps Clean / Enterprise Compliant)
**Why:** …
**Credit tier:** …
**Compliance:** Pass | Fail | Risk
```

### Prompt conventions

| Pattern | Use |
|---------|-----|
| `#file path/to/file` | Default attachment (≤3 files) |
| Active selection | Single-function debug |
| `@workspace` | Avoid unless tech-lead approved |
| Model tier in prompt | `Model: Haiku 4.5` (S), `Sonnet 4.6` (M), frontier (L + approval) |
| Standards text | **Never** re-paste — reference `copilot-instructions.md` |

## Verify after install

- [ ] Copilot Chat loads repo instructions (check VS Code Copilot settings / usage panel).
- [ ] `.copilotignore` excludes `node_modules/`, `dist/`, lockfiles.
- [ ] PR template or team wiki links to Scope-Down checklist in `copilot-instructions.md`.
- [ ] One pilot engineer runs Exercise 1 Before vs After (`examples/token-saver/cache_friendly_patterns/01_stable_system_prefix.md` in your service repo).

## Full curriculum

See [README.md](README.md) for UBB economics, admin budgets, and rollout checklist.
