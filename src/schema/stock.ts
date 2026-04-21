import { z } from 'zod';
import { stockStatusSchema } from './enums';

// Base schemas
export const stockSchema = z.object({
  id: z.number().int().positive().optional(),
  warehouse_id: z.number().int().positive(),
  manager_id: z.number().int().positive(),
  company_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const stockMaterialSchema = z.object({
  id: z.number().int().positive().optional(),
  stock_id: z.number().int().positive().optional(),
  material_id: z.number().int().positive(),
  quantity: z.number().nonnegative().nullable().optional(),
  minimum_threshold_quantity: z
    .number()
    .int()
    .nonnegative()
    .nullable()
    .optional(),
  current_stock: z.number().int().nonnegative().nullable().optional(),
  specifications: z.string().max(1000).nullable().optional(),
  status: stockStatusSchema.default('IN_STOCK'),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Stock = z.infer<typeof stockSchema>;
export type StockMaterial = z.infer<typeof stockMaterialSchema>;
