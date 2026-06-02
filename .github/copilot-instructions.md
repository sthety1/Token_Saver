# Enterprise Copilot — FinOps & Security

If org instructions already cover compliance or Azure, keep this file to FinOps and context only — all applicable sets bill as input together.

Optimize **GitHub AI Credits** (1 credit = $0.01 USD). Protect data sovereignty.

## Mission

Minimal, correct, testable changes. Cheapest model tier. No scope creep. Azure/TDD: `.github/instructions/` on matching paths.

## Token economics

**Model tier** — default **GPT-5.3-Codex** is costly; downshift unless user chose L:

- **S:** syntax, rename, one-function fix → **GPT-5 mini**, **GPT-5.4 nano**, **Raptor mini**, **Haiku 4.5**
- **M:** ≤3 files → **GPT-5.4 mini**, **Haiku 4.5**, **GPT-5 mini**; **Sonnet 4.6** if cheaper models fail
- **L:** architecture, cross-cutting debug → **GPT-5.3-Codex**, **GPT-5.4**, **Sonnet 4.6**; **Opus** / **GPT-5.5** only on explicit request — warn pool impact

Included models still bill per token — not free Chat.

**Modes (cheapest first):** inline/NES (free) → Ask/Edit → Agent/CLI/cloud agent (each step re-bills context).

**Output:** patch/diff default; no reprints or instruction recap. debug/review: ≤8 bullets. implement: Plan ≤3 → Changes → Tests if present. FinOps tip only for L-tier, `@workspace`, or >3 files.

**Agent:** ≤3 files/step; Chat for one-shot; Scope-Down between steps.

**Session:** same thread when prefix stable; cached input still bills. No model switch mid-thread. New thread after model change, big attachments, or edits to this file.

## Billable surfaces

Chat, Agent, CLI, cloud agent, Spaces → pooled credits. PR code review → credits + Actions minutes; scope diffs. No cheap-model fallback when user budget exhausted.

## Context

Max **3** `#file` references; active selection over `@workspace`; refuse vague workspace scope. Never: vendor trees, dist/bin/obj, lockfiles, minified bundles, CI logs >100 lines, PII, secrets. Remind `.copilotignore` on bleed. GPT-5.4 >272K / Gemini Pro >200K: surcharges.

## Cache

Stable prefix — no re-pasting standards. Append-at-EOF; diffs not full files unless <80 lines. Stable imports per session.

## Compliance

Synthetic IDs and `contoso.test` only. Refuse prod data/secrets/PII. Peer review + static analysis + CI required. Copilot and org-approved tools only.

## Scope-Down (vague prompts)

Task type | ≤3 paths | S/M/L | thread continue/new | no prod data | split if L

## References

Enterprise **3,900** credits/user/mo (**7,000** promo through Sep 1, 2026). [UBB](https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-organizations-and-enterprises) · [Pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing) · Kit: `INSTALL.md`, `README.md`
