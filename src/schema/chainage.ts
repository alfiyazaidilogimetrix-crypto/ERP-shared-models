import { z } from 'zod';

export const chainageConsumptionLedgerSchema = z.object({
  id: z.number().int().positive().optional(),
  chainage_data: z.any(), // or use z.record(z.any()) for more specificity
  projectId: z.number().int().positive(),
  project: z.any().optional(), // You might want to create a more specific Project schema
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type ChainageConsumptionLedger = z.infer<
  typeof chainageConsumptionLedgerSchema
>;
