import { z } from 'zod';

export const scopeSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const projectSopesSchema = z.object({
  id: z.number().int().positive().optional(),
  scope_id: z.number().int().positive(),
  category_type: z.string().min(1),
  activity_id: z.number().int().positive(),
  length: z.number().int(),
  unit_id: z.number().int().positive(),
  quantity: z.number().int(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Scope = z.infer<typeof scopeSchema>;
export type ProjectSopes = z.infer<typeof projectSopesSchema>;

