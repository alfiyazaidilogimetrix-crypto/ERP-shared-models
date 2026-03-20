import { z } from 'zod';

export const materialBoqSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const materialBoqItemSchema = z.object({
  id: z.number().int().positive().optional(),
  material_boq_id: z.number().int().positive(),
  material_id: z.number().int().positive().optional().nullable(),
  unit_id: z.number().int().positive(),
  activity_id: z.number().int().positive(),
  category_id: z.number().int().positive().optional().nullable(),
  item_description: z.string().optional().nullable(),
  scope_quantity: z.number().nullable().optional(),
  purchased_quantity: z.number().nullable().optional(),
  balanced_quantity: z.number().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
  workOrderItems: z.array(z.any()).optional(),
});

export type MaterialBoq = z.infer<typeof materialBoqSchema>;
export type MaterialBoqItem = z.infer<typeof materialBoqItemSchema>;
