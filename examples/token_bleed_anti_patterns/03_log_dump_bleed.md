# Anti-Pattern 3: Log Dump Bleed

Pasting full CI or production logs into Copilot Chat is one of the fastest ways to burn **thousands of input tokens** in a single turn. Logs are repetitive, high-entropy, and rarely need more than 30–50 lines around the failure.

---

## Context

Azure DevOps pipeline `contoso-retail-ci` failed on stage `integration-tests`.

---

### Before (Token Wasteful / Non-Compliant)

> Here is the full log from the failed run (52,000 lines attached as text file).  
> Find the root cause and fix all failing tests. @workspace Model: GPT-5.5

**Mechanisms of waste:**

- 52k lines ≈ **hundreds of thousands of tokens** if ingested
- Duplicate stack traces across retries
- `@workspace` compounds the bleed

**Credit tier:** **High** (can exceed 500 credits on frontier models)

**Compliance:** **Fail risk** — production logs may contain hostnames, account IDs, email addresses in assertion output

---

### After (FinOps Clean / Enterprise Compliant)

> #file tests/Contoso.Retail.Orders.Integration/PlaceOrderTests.cs  
> Failure excerpt (redacted):  
> ```text  
> [FAIL] PlaceOrderTests.Should_publish_OrderPlaced_event  
> Expected: MessagePublished  
> Actual:   TimeoutException after 30s  
> CorrelationId: 7f3c…ab12  
> ServiceBus: topic orders-events not found (404)  
> ```  
> Model: Claude Haiku 4.5  
> Diagnose test setup vs missing topic configuration. No other files unless you justify.

**Why:** Error signature + one test file = sufficient signal. Correlation ID truncated; no customer payloads.

**Credit tier:** **Low**

**Compliance:** Pass

---

## Redaction template for engineers

```text
[STAGE] {name}
[RESULT] {Failed|Succeeded}
[TEST] {fully.qualified.name}
[ASSERT] {one line}
[ERROR_CODE] {e.g. 404, IDX10503}
[CORRELATION] {first 8 chars}…{last 4 chars}
```

Store full logs in Application Insights / Log Analytics — link by correlation ID in the ticket, not in Copilot.
