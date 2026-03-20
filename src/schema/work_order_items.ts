import { z } from 'zod';

export const workOrderItemsSchema = z.object({
  id: z.number().int().positive().optional(),
  work_order_id: z.number().int().positive(),
  material_boq_item_id: z.number().int().positive(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type WorkOrderItems = z.infer<typeof workOrderItemsSchema>;
