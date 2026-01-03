import { z } from 'zod';

export const stockSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1, 'Stock name is required'),
  material_code: z.string().nullable().optional(),
  categoryId: z.number().int().nullable().optional(),
  unitId: z.number().int().nullable().optional(),
  status: z.enum(['in_stock', 'out_of_stock']).default('in_stock'),
  minimum_threshold_quantity: z.number().int().nullable().optional(),
  unit_of_measure: z.string().nullable().optional(),
  current_stock: z.number().int().nullable().optional(),
  quantity: z.number().int().nullable().optional(),
  specifications: z.string().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Stock = z.infer<typeof stockSchema>;
