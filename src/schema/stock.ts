import { z } from 'zod';
import { stockStatusSchema } from './enums';
// Base schemas
export const stockSchema = z.object({
  id: z.number().int().positive().optional(),
  material_id: z.number().int().positive().nullable().optional(),
  locationId: z.number().int().positive().nullable().optional(),

  status: z.enum(stockStatusSchema.options).default('in_stock'),
  minimum_threshold_quantity: z
    .number()
    .int()
    .nonnegative()
    .nullable()
    .optional(),
  current_stock: z.number().int().nonnegative().default(0),
  quantity: z.number().int().nonnegative().nullable().optional(),
  specifications: z.string().max(1000).nullable().optional(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Stock = z.infer<typeof stockSchema>;
