# Anti-Pattern 4: Dependency Tree Explosion

> **Category:** `token-bleed`  
> **Skill:** Trace one vertical slice (≤3 files) instead of whole-solution reasoning  
> **Supporting files:** none

## Scenario

New engineer onboarding to Contoso.Retail — wants to understand how checkout calls inventory.

---

### Before (Token Wasteful / Non-Compliant)

> @workspace Explain how the whole Contoso.Retail solution works — every project, dependency, and test. Draw the full architecture and list every NuGet package. Use Gemini 2.5 Pro.

**Mechanisms of waste:**

- Solution-wide graph ≠ onboarding answer
- Package lists are readable from `dotnet list package` locally (free)
- Frontier model on maximal context

**Credit tier:** **High**

**Compliance:** **Risk** — real solutions may expose internal package feeds in prose output

---

### After (FinOps Clean / Enterprise Compliant)

> #file src/Contoso.Retail.Checkout/Handlers/PlaceOrderHandler.cs  
> #file src/Contoso.Retail.Inventory.Contracts/IInventoryQuery.cs  
> #file tests/Contoso.Retail.Checkout.Tests/PlaceOrderHandlerTests.cs  
> Model: GPT-5 mini  
> Trace the call path from `PlaceOrderHandler` to inventory lookup only. Output: sequence diagram (≤8 steps) + interfaces touched. Do not scan other projects.

**Why:** Three files define the integration boundary. Contracts file is the **semantic seam** — not the entire Inventory service implementation.

**Credit tier:** Before = **High** | After = **Low–Medium**

**Compliance:** **Pass**

---

## When full-solution docs are appropriate

Generate architecture docs **offline** (scheduled doc agent with budget approval, or human-authored ADRs). Do not use ad-hoc "explain everything" chat during sprint work.

---

## Azure NorthStar framing (After follow-up prompt)

> Same three files. Describe how this handler should publish to **Azure Service Bus** and log to **Application Insights** with `correlationId` — align with repo `copilot-instructions.md`.
