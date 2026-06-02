# Exercise 1: Stable System Prefix

Repository-wide instructions in [`.github/copilot-instructions.md`](../../.github/copilot-instructions.md) load automatically. They form a **stable prefix** that Copilot can reuse across turns. Re-pasting your architecture handbook every message forces fresh input billing and destroys cache-hit ratio.

---

## Scenario

You are implementing a new `RefundRequested` Service Bus handler in `Contoso.Retail.Orders`.

---

### Before (Token Wasteful / Non-Compliant)

**Turn 1 prompt:**

> We are an Azure enterprise. Use API Management, Service Bus, Application Insights, managed identity, Key Vault, Polly retries, structured logging with correlation IDs, xUnit TDD, Bicep IaC, and domain-bounded microservices. Never use god-controllers.  
> Add a handler for `RefundRequested` in the Orders worker.

**Turn 2 prompt (same chat):**

> Same standards as before — APIM, Service Bus, App Insights, MI, Key Vault, Polly, correlation IDs, xUnit, Bicep, no god-controllers.  
> Now add unit tests for the handler you just wrote.

**Estimated tokens:** ~450 tokens of standards × 2 turns = **900 tokens of duplicate fresh input** before your actual task tokens.

---

### After (FinOps Clean / Enterprise Compliant)

**Turn 1 prompt:**

> Add `RefundRequested` Service Bus handler in `Orders.Worker`, following repo instructions. Idempotent via `ProcessedMessageStore`. File: `#file src/Orders.Worker/Handlers/`

**Turn 2 prompt (same chat, prefix warm):**

> Add xUnit tests for the handler added in the previous turn. Only `#file tests/Orders.Worker.Tests/RefundRequestedHandlerTests.cs` and the handler file.

**Why:** Standards live in `copilot-instructions.md` once; turns only add **delta task** text. Turn 2 reuses cached prefix including instructions + prior file context.

**Credit tier:** Before = **Medium–High** (duplicate standards). After = **Low–Medium**.

**Compliance:** Pass — no extra data exposure from prompt bloat.

---

## Team action

1. Copy [`.github/copilot-instructions.md`](../../.github/copilot-instructions.md) into each service repo.
2. Ban "standards preamble" in code review for Copilot-generated PR descriptions and chat exports.
3. Extend with path-specific rules under `.github/instructions/*.instructions.md` when needed (e.g., `applyTo: "**/*.cs"`).
