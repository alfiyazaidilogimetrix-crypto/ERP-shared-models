import { z } from 'zod';
import { projectStatusSchema } from './enums';

export const projectSchema = z.object({
  id: z.number().int().positive().optional(),
  project_type_id: z.number().int().positive().nullable().optional(),
  project_name: z.string().min(1),
  project_code: z.string().min(1),
  start_date: z.date().nullable().optional(),
  end_date: z.date().nullable().optional(),
  budget: z.string().nullable().optional(),
  status: projectStatusSchema.default('PLANNED'),
  client: z.string().nullable().optional(),
  description: z.string().nullable().optional(),
  progress: z.number().int().min(0).max(100).nullable().optional(),
  manager_id: z.number().int().positive().nullable().optional(),
  district: z.string().nullable().optional(),
  state: z.string().nullable().optional(),
  pincode: z.string().nullable().optional(),
  from_length: z.string().nullable().optional(),
  to_length: z.string().nullable().optional(),
  total_length: z.string().nullable().optional(),
  total_chainage: z.array(z.string()).optional(),
  company_id: z.number().int().positive(),
  head_office_id: z.number().int().positive(),
  branch_office_id: z.number().int().positive(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
  projectCategories: z.array(z.any()).optional(),
});


export type Project = z.infer<typeof projectSchema>;

