import { z } from "zod";

export const chainageConsumptionLedgerSchema = z.object({
  id: z.number().int().positive().optional(),
  chainage: z.string(),
  materials: z.number(),
  labours: z.number(),
  equipment: z.number(),
  sub_contractor: z.number(),
  total_cost: z.number(),
  projectId: z.number().int(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type ChainageConsumptionLedger = z.infer<typeof chainageConsumptionLedgerSchema>;
