import { z } from 'zod';

export const materialBoqSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  company_id: z.number().int().positive(),
  head_office_id: z.number().int().positive(),
  branch_office_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const materialBoqItemSchema = z.object({
  id: z.number().int().positive().optional(),
  material_boq_id: z.number().int().positive(),
  item_no: z.string().optional().nullable(),
  material_id: z.number().int().optional().nullable(),
  unit_id: z.number().int().positive(),
  item_description: z.string().optional().nullable(),
  scope_quantity: z.number().nullable().optional(),
  purchased_quantity: z.number().nullable().optional(),
  balanced_quantity: z.number().nullable().optional(),
  rate: z.number().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
  workOrderItems: z.array(z.any()).optional(),
});

export type MaterialBoq = z.infer<typeof materialBoqSchema>;
export type MaterialBoqItem = z.infer<typeof materialBoqItemSchema>;
