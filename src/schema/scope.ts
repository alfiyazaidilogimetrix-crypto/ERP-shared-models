import { z } from 'zod';

export const scopeSchema = z.object({
  id: z.number().int().positive().optional(),
  activity_id: z.number().int().positive(),
  length: z.number().int(),
  unit_id: z.number().int().positive(),
  quantity: z.number().int(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Scope = z.infer<typeof scopeSchema>;
