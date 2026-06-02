# Cache-Friendly Patterns

**Golden rule:** Keep your context **deterministic** across turns so GitHub can bill reused prefix tokens at **cached-input** rates (typically ~10× cheaper than fresh input for many models).

Every exercise uses the same format — see [exercise template](../../templates/exercise-template.md) and [INSTALL.md](../../INSTALL.md).

## Exercises

| # | File | Skill |
|---|------|--------|
| 1 | [01_stable_system_prefix.md](01_stable_system_prefix.md) | Move standards into `.github/copilot-instructions.md` instead of re-pasting |
| 2 | [02_sequential_append_edits.md](02_sequential_append_edits.md) | Append-at-EOF vs whole-file reshuffle |
| 3 | [03_semantic_chunk_boundaries/README.md](03_semantic_chunk_boundaries/README.md) | Attach semantic chunks, not god-files |
| 4 | [04_chat_vs_inline_workflow.md](04_chat_vs_inline_workflow.md) | Route work to the unlimited inline lane |

## Measuring cache benefit

1. Open Copilot usage/credits indicator in VS Code (requires current Copilot extension).
2. Run **Before** in a new chat; note credits for turn 1 and turn 2.
3. Run **After** in a new chat with the same two-turn pattern.
4. Turn 2 **After** should cost less when the prefix (instructions + unchanged files) is stable.

> Cached pricing applies to reused context within a session. Exact rates vary by model — see [Models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing).

## What invalidates cache

- Switching frontier ↔ fast models mid-thread
- Reordering imports or rewriting the top 200 lines of a large attached file
- Attaching a different 8k-line file each turn
- Starting a new chat when the prior prefix was still valid
