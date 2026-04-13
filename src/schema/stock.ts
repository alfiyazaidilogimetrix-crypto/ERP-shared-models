import { z } from 'zod';
import { stockStatusSchema } from './enums';

// Base schemas
export const stockSchema = z.object({
  id: z.number().int().positive().optional(),
  material_id: z.number().int().positive(),
  warehouse_id: z.number().int().positive(),
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
  manager_id: z.number().int().positive(),
  company_id: z.number().int().positive(),
  head_office_id: z.number().int().positive(),
  branch_office_id: z.number().int().positive(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Stock = z.infer<typeof stockSchema>;
