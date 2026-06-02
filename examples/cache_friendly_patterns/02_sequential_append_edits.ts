/**
 * Contoso.Retail — Cache-friendly edit discipline (illustration)
 *
 * FINOPS LESSON:
 * - APPEND at EOF keeps line numbers 1..N stable → prefix cache survives.
 * - WHOLESALE reorder (imports, moving types) shifts the file fingerprint → cache miss.
 *
 * Run two Copilot Chat sessions on this file:
 *   A) Ask to "add export function validateRefund at bottom"
 *   B) Ask to "alphabetize all imports and reorder all interfaces"
 * Compare turn-2 credit cost in each session.
 */

// --- Stable header block: do not rewrite mid-session -----------------
export interface OrderLine {
  sku: string;
  quantity: number;
  unitPrice: number;
}

export interface Order {
  orderId: string;
  customerId: string;
  lines: OrderLine[];
  correlationId: string;
}

// --- Append zone: safe for cache-friendly additions -------------------
export function calculateOrderTotal(order: Order): number {
  return order.lines.reduce((sum, line) => sum + line.quantity * line.unitPrice, 0);
}

// COPILOT TASK (After pattern): "Append validateRefund below calculateOrderTotal"
// export function validateRefund(order: Order): boolean { ... }

// --- Anti-pattern zone: wholesale refactor invalidates cache ----------
// COPILOT TASK (Before pattern): "Reorganize entire file: imports first,
// then types alphabetically, then all functions alphabetically by name"
// Result: every line potentially moves → full file treated as new input next turn.
