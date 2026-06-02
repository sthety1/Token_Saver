/**
 * Contoso.Retail — supporting file for Exercise 2 (see 02_sequential_append_edits.md)
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

// After pattern: append validateRefund here (see exercise markdown)
