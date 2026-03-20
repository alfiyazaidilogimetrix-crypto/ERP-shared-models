import { z } from 'zod';

export const projectCategorySchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  category_id: z.number().int().positive(),
});

export type ProjectCategory = z.infer<typeof projectCategorySchema>;
