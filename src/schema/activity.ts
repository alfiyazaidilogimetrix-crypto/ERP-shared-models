import { z } from 'zod';

export const activitySchema = z.object({
  id: z.number().int().positive().optional(),
  category_type: z.string().min(1),
  name: z.string().min(1),
  unit_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Activity = z.infer<typeof activitySchema>;
