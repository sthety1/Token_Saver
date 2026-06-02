# Anti-Pattern 2: Vendor Bundle Bloat

> **Category:** `token-bleed`  
> **Skill:** Attach source + test only — never lockfiles, dist, or node_modules  
> **Supporting files:** none

## Scenario

You need Copilot to explain why `createOrder` fails at runtime in the Contoso.Retail Node API.

---

### Before (Token Wasteful / Non-Compliant)

> @workspace Here is our project — I attached context from the repo root.  
> #file package-lock.json  
> #file dist/server.js  
> #file dist/server.js.map  
> Why does `createOrder` throw `TypeError: Cannot read properties of undefined`?

**Mechanisms of waste:**

- `package-lock.json` — tens of thousands of tokens of dependency metadata
- `dist/server.js` — minified, low-signal output
- Source maps duplicate content

**Credit tier:** **High**

**Compliance:** **Risk** — vendor code dominates context; no PII but poor signal-to-noise

---

### After (FinOps Clean / Enterprise Compliant)

> #file src/api/orders/createOrder.ts  
> #file src/api/orders/createOrder.test.ts  
> Stack: `TypeError: Cannot read properties of undefined` at line 42 in test `createOrder_mapsDtoToCommand`.  
> Model: GPT-5 mini.  
> Propose fix using our `OrderCommand` interface only — do not read lockfiles or dist.

**Optional interface stub** (paste if types are external):

```typescript
export interface OrderCommand {
  orderId: string;
  customerId: string;
  lines: Array<{ sku: string; quantity: number }>;
}
```

**Why:** Source + test = semantic minimum. Lockfile adds zero diagnostic value for an undefined-property bug.

**Credit tier:** Before = **High** | After = **Low**

**Compliance:** **Pass**

---

## Team action

1. Add [`.copilotignore`](../../.copilotignore) to the repo root.
2. Never attach: `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, `node_modules/**`, `dist/**`, minified bundles.

## Related

- [04_dependency_tree_explosion.md](04_dependency_tree_explosion.md)
- [Master Guide — `.copilotignore`](../../README.md#34-copilotignore-recommended-patterns)
