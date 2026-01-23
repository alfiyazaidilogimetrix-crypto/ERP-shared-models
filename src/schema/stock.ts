import { z } from 'zod';
import { stockStatusSchema } from './enums';
// Base schemas
export const stockSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1).max(200),
  material_code: z.string().max(100).nullable().optional(),

  categoryId: z.number().int().positive().nullable().optional(),
  unitId: z.number().int().positive().nullable().optional(),
  locationId: z.number().int().positive().nullable().optional(),

  status: z.enum(stockStatusSchema.options).default('in_stock'),
  minimum_threshold_quantity: z
    .number()
    .int()
    .nonnegative()
    .nullable()
    .optional(),
  unit_of_measure: z.string().max(50).nullable().optional(),
  current_stock: z.number().int().nonnegative().default(0),
  quantity: z.number().int().nonnegative().nullable().optional(),
  specifications: z.string().max(1000).nullable().optional(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Stock = z.infer<typeof stockSchema>;
