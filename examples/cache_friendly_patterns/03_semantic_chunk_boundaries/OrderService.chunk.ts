/**
 * Contoso.Retail.Orders — SEMANTIC CHUNK (~120 lines)
 * Attach THIS file (or a selection) when asking Copilot about order placement.
 * Do not attach OrderService.full.ts.
 */
import { ServiceBusClient } from "@azure/service-bus";

export interface PlaceOrderCommand {
  orderId: string;
  customerId: string;
  correlationId: string;
  lines: Array<{ sku: string; quantity: number }>;
}

export class OrderService {
  constructor(
    private readonly bus: ServiceBusClient,
    private readonly topic: string,
    private readonly logger: { info: (msg: string, meta: object) => void }
  ) {}

  async placeOrder(cmd: PlaceOrderCommand): Promise<void> {
    const sender = this.bus.createSender(this.topic);
    try {
      await sender.sendMessages({
        body: { type: "OrderPlaced", ...cmd },
        messageId: cmd.orderId,
        correlationId: cmd.correlationId,
      });
      this.logger.info("OrderPlaced published", {
        orderId: cmd.orderId,
        correlationId: cmd.correlationId,
      });
    } finally {
      await sender.close();
    }
  }

  async validateInventory(cmd: PlaceOrderCommand): Promise<boolean> {
    // stub: inventory service boundary
    return cmd.lines.every((l) => l.quantity > 0);
  }
}

// FINOPS: ~3k tokens attached vs ~35k for full god-file — 10x+ input savings per turn
