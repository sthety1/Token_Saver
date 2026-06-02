# Exercise 2: Sequential Append Edits

> **Category:** `cache-friendly`  
> **Skill:** Append-at-EOF vs whole-file reshuffle for cache stability  
> **Supporting files:** [02_sequential_append_edits.ts](02_sequential_append_edits.ts)

## Scenario

You are extending `CartService` in Contoso.Retail with a new `validateRefund` helper. You will run **two Copilot Chat sessions** on the same file and compare turn-2 credit cost.

---

### Before (Token Wasteful / Non-Compliant)

**Turn 1 prompt:**

> #file examples/cache_friendly_patterns/02_sequential_append_edits.ts  
> Reorganize the entire file: group imports first, sort types alphabetically, then sort all functions alphabetically by name.

**Turn 2 prompt (same chat):**

> Add `validateRefund` below `calculateOrderTotal`.

**Mechanisms of waste:**

- Turn 1 moves most lines → full file fingerprint changes → cache miss on turn 2
- Line-number-sensitive prefix no longer matches prior turn

**Credit tier:** **Medium–High** (turn 2 billed largely as fresh input)

**Compliance:** **Pass**

---

### After (FinOps Clean / Enterprise Compliant)

**Turn 1 prompt:**

> #file examples/cache_friendly_patterns/02_sequential_append_edits.ts  
> Append `validateRefund(order: Order): boolean` below `calculateOrderTotal`. Do not reorder imports or existing types.

**Turn 2 prompt (same chat, prefix warm):**

> Add unit tests for `validateRefund` in `#file tests/CartService.test.ts` only.

**Why:** Append-at-EOF keeps lines 1..N stable so the cached prefix survives across turns.

**Credit tier:** Before = **Medium–High** | After = **Low**

**Compliance:** **Pass**

---

## Team action

1. In code review, reject Copilot-driven "cleanup" refactors mid-feature branch when a chat session is active.
2. Run formatters and import sorting **outside** active Copilot threads, or start a new thread with fewer attachments afterward.
