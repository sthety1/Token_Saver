# Token Bleed Anti-Patterns

**Token bleed** is uncontrolled input expansion: workspace scans, vendor trees, log dumps, and dependency explosions that drain your organization's **pooled GitHub AI Credits** without improving answer quality.

Each file is a side-by-side prompt lab using synthetic Contoso.Retail scenarios. Format matches [exercise template](../../templates/exercise-template.md).

## Index

| # | File | Bleed mechanism |
|---|------|-----------------|
| 1 | [01_workspace_vs_file_scope.md](01_workspace_vs_file_scope.md) | `@workspace` blast radius |
| 2 | [02_vendor_bundle_bloat.md](02_vendor_bundle_bloat.md) | Lockfiles, `dist/`, `node_modules` |
| 3 | [03_log_dump_bleed.md](03_log_dump_bleed.md) | Full CI/CD logs in chat |
| 4 | [04_dependency_tree_explosion.md](04_dependency_tree_explosion.md) | Whole-solution reasoning |
| 5 | [05_pii_and_production_data.md](05_pii_and_production_data.md) | Compliance failure + credit waste |

## Credit tier legend

| Tier | Indicative single-turn cost (org pool) |
|------|----------------------------------------|
| **Low** | &lt; 5 credits — scoped file, fast model, warm cache |
| **Medium** | 5–50 credits — several files or medium model |
| **High** | 50+ credits — workspace, logs, frontier model, agent loops |

Exact consumption depends on model and token counts. See [Models and pricing](https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing).

## Prevention

Run the **Scope-Down Framework** in the [Master Guide](../../README.md#module-3-active-context-management-eliminating-token-bleed) before every **High** tier submission.
