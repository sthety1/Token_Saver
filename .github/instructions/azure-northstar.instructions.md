---
applyTo: "**/*.{cs,bicep,tf}"
---

# Azure NorthStar defaults

When generating or modifying code in matching paths, apply these patterns unless the repo already defines alternatives:

| Concern | Default |
|---------|---------|
| Edge / API | Azure API Management in front of domain APIs; versioned REST; no god-controllers |
| Async integration | Azure Service Bus queues/topics; idempotent handlers; dead-letter subqueues |
| Events | Azure Event Grid for fan-out notifications where appropriate |
| Identity | Managed identity; Key Vault secret references — never hardcode secrets |
| Observability | Application Insights + OpenTelemetry; structured logs with `correlationId` on every request and message handler |
| Resilience | Polly retries with jitter; circuit breaker; explicit timeout budgets |
| Data | Bounded contexts; repository interfaces; no cross-module EF navigation hacks |
| IaC | Bicep/Terraform modules; Azure Policy-aware resource naming (`rg-{env}-{workload}`) |

## Minimal logging template (C#)

```csharp
_logger.LogInformation(
    "Handled {EventName} for {EntityId} with {CorrelationId}",
    nameof(OrderPlaced),
    orderId,
    Activity.Current?.Id ?? httpContext.TraceIdentifier);
```

## Minimal Service Bus handler shape (C#)

```csharp
public async Task HandleAsync(OrderPlaced message, CancellationToken ct)
{
    using var scope = _logger.BeginScope(new Dictionary<string, object>
    {
        ["correlationId"] = message.CorrelationId
    });
    // idempotent: check ProcessedMessageStore before side effects
}
```

Customize APIM, Service Bus, Key Vault, and naming rows for your landing zone before wide rollout.
