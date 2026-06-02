# Anti-Pattern 2a: Vendor Bundle Bloat (Before)

## Scenario

You need Copilot to explain why `createOrder` fails at runtime in the Node API.

---

### Before (Token Wasteful / Non-Compliant)

> @workspace Here is our project — I attached context from the repo root.  
> #file package-lock.json  
> #file dist/server.js  
> #file dist/server.js.map  
> Why does `createOrder` throw `TypeError: Cannot read properties of undefined`?

**What got billed:**

- `package-lock.json` — tens of thousands of tokens of dependency metadata
- `dist/server.js` — minified, low-signal, unreadable by humans and models alike
- Source maps duplicate content

**Credit tier:** **High**

**Compliance:** Pass (no PII in lockfile) but **IP/noise risk** — vendor code dominates context

---

## What you should never attach

- `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`
- `node_modules/**`, `dist/**`, `build/**`
- Minified bundles (`.min.js`)
- Generated gRPC/protobuf outputs at full tree scale
