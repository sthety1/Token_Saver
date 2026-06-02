# Anti-Pattern 2b: Vendor Bundle Bloat (After)

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

**Why:** Source + test = semantic minimum. Lockfile adds zero diagnostic value for a undefined-property bug.

**Credit tier:** **Low**

**Compliance:** Pass

---

## Related: see also

- [04_dependency_tree_explosion.md](../04_dependency_tree_explosion.md)
- [`.copilotignore` patterns](../../../README.md#34-copilotignore-recommended-patterns) in Master Guide
