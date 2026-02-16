import { z } from 'zod';

export const materialSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1),
  material_code: z.string().nullable().optional(),
  activityId: z.number().int().positive().nullable().optional(),
  unitId: z.number().int().positive().nullable().optional(),
  category_type: z.string().min(1),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Material = z.infer<typeof materialSchema>;
