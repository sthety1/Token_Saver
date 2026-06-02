# Anti-Pattern 5: PII and Production Data in Prompts

> **Category:** `token-bleed`  
> **Skill:** Use synthetic repro payloads — never production JSON, SQL, or log exports  
> **Supporting files:** none

## Scenario

Orders API returns 500 for a specific customer checkout.

---

### Before (Token Wasteful / Non-Compliant)

> Here is the production response body and DB row — fix the bug:  
> ```json  
> {  
>   "customerId": "cust_live_8844221",  
>   "email": "jane.doe@customer-example.com",  
>   "phone": "+1-555-0142",  
>   "paymentLast4": "4242",  
>   "billingAddress": "742 Evergreen Terrace, Springfield",  
>   "orderTotal": 1299.99  
> }  
> ```  
> ```sql  
> SELECT * FROM orders WHERE customer_id = 'cust_live_8844221';  
> ```  
> @workspace Model: Claude Sonnet 4.6

**Violations:**

- Customer PII and payment-adjacent data in a third-party AI context
- Full row dump maximizes tokens
- Workspace scan may pull more fixtures with secrets

**Credit tier:** **High**

**Compliance:** **Fail** — report to security per incident policy; rotate any exposed credentials

---

### After (FinOps Clean / Enterprise Compliant)

> #file src/Contoso.Retail.Orders/Handlers/PlaceOrderHandler.cs  
> Repro uses **synthetic** payload only:  
> ```json  
> {  
>   "customerId": "cust_000123",  
>   "email": "user@contoso.test",  
>   "lines": [{ "sku": "SKU-TEST", "quantity": 1 }]  
> }  
> ```  
> Expected HTTP 201, actual 500 with `NullReferenceException` at handler line 88. Model: Haiku 4.5. No production data.

**Why:** Minimal repro without PII; single handler file; fast model.

**Credit tier:** Before = **High** | After = **Low**

**Compliance:** **Pass**

---

## Approved substitutes

| Need | Use |
|------|-----|
| Customer record | Factory: `cust_{sixDigitId}` |
| Email | `user{n}@contoso.test` |
| Payment | Test PAN from docs (e.g. Stripe test cards) in **local** code only, not chat |
| DB state | Seed script reference by ID, not `SELECT *` paste |
| Logs | Redacted shape per [03_log_dump_bleed.md](03_log_dump_bleed.md) |

---

## Security review gate

All Copilot-assisted changes merge through:

1. Human peer review (no "AI-only" commits)
2. SonarQube / static analysis
3. CI unit + integration tests
4. Secret scanning (gitleaks, GitHub secret scanning)
