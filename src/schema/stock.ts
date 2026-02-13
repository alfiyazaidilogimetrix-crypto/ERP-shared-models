import { z } from 'zod';
import { stockStatusSchema } from './enums';

// Base schemas
export const stockSchema = z.object({
  id: z.number().int().positive().optional(),
  material_id: z.number().int().positive(),
  pincode: z.string(),
  state: z.string(),
  district: z.string(),
  status: stockStatusSchema.default('IN_STOCK'),
  minimum_threshold_quantity: z
    .number()
    .int()
    .nonnegative()
    .nullable()
    .optional(),
  current_stock: z.number().int().nonnegative().nullable().optional(),
  quantity: z.number().int().nonnegative().nullable().optional(),
  specifications: z.string().max(1000).nullable().optional(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Stock = z.infer<typeof stockSchema>;
