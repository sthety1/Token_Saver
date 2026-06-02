# Exercise 3: Semantic Chunk Boundaries

> **Category:** `cache-friendly`  
> **Skill:** Attach semantic chunks, not god-files  
> **Supporting files:** [OrderService.chunk.ts](OrderService.chunk.ts), [OrderService.full.ts](OrderService.full.ts)

## Scenario

Split god-files by **bounded context** before attaching them to Copilot Chat. One chat turn should carry one **semantic chunk** — the minimum code that answers the question.

## Files

| File | Lines (approx.) | Use in chat |
|------|-----------------|-------------|
| `OrderService.chunk.ts` | ~120 | **Yes** — order placement tasks |
| `OrderService.full.ts` | 400+ (simulated) | **No** — training anti-pattern only |

---

### Before (Token Wasteful / Non-Compliant)

> #file examples/cache_friendly_patterns/03_semantic_chunk_boundaries/OrderService.full.ts  
> Add correlation ID logging to `placeOrder` and validate inventory before publish.

**Mechanisms of waste:**

- Input tokens scale with unrelated reporting, tax, and loyalty code
- Large attachment increases cache invalidation surface on any edit

**Credit tier:** **High**

**Compliance:** **Pass**

---

### After (FinOps Clean / Enterprise Compliant)

> #file examples/cache_friendly_patterns/03_semantic_chunk_boundaries/OrderService.chunk.ts  
> Add inventory validation call before Service Bus publish in `placeOrder`. Selection: lines 24–44 only.

---

**Why:** Input tokens scale with attached source volume. Unrelated reporting/tax/loyalty code is **attention noise** and **financial waste**.

**Credit tier:** Before = **High** | After = **Low**

**Compliance:** Pass — synthetic code only.

## Refactor guidance for tech leads

- Enforce max file length in SonarQube (e.g., 400 lines soft, 600 hard).
- Align folders to domain boundaries: `Orders/`, `Payments/`, `Catalog/` — each Copilot attachment maps to one deployable unit.
