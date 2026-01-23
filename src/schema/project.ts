import { z } from 'zod';
import { projectTypeSchema, projectStatusSchema } from './enums';

export const projectSchema = z.object({
  id: z.number().int().positive().optional(),
  project_type: projectTypeSchema,
  project_name: z.string().min(1),
  project_code: z.string().min(1),
  start_date: z.date().nullable().optional(),
  end_date: z.date().nullable().optional(),
  budget: z.string().nullable().optional(),
  status: projectStatusSchema.default('PLANNED'),
  client: z.string().nullable().optional(),
  description: z.string().nullable().optional(),
  manager_id: z.number().int().positive().nullable().optional(),
  location_id: z.number().int().positive().nullable().optional(),
  progress: z.number().int().min(0).max(100).nullable().optional(),
  other_details: z.any().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const hamSpecificDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int(),
  annuity_amount: z.string().nullable().optional(),
  annuity_period: z.number().int().nullable().optional(),
  construction_period: z.number().int().nullable().optional(),
  maintenance_responsibility: z.string().nullable().optional(),
  progress: z.number().int().min(0).max(100).nullable().optional(),
});

export const epcSpecificDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int(),
  engineering_scope: z.string().nullable().optional(),
  procurement_budget: z.string().nullable().optional(),
  construction_timeline: z.string().nullable().optional(),
  performance_guarantee: z.string().nullable().optional(),
  progress: z.number().int().min(0).max(100).nullable().optional(),
});

export const botSpecificDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int(),
  concession_period: z.number().int().nullable().optional(),
  estimated_operating_cost: z.string().nullable().optional(),
  toll_revenue_collection_enabled: z.boolean().default(false),
  transfer_condition: z.string().nullable().optional(),
});

export type Project = z.infer<typeof projectSchema>;
export type HAMSpecificDetails = z.infer<typeof hamSpecificDetailsSchema>;
export type EPCSpecificDetails = z.infer<typeof epcSpecificDetailsSchema>;
export type BOTSpecificDetails = z.infer<typeof botSpecificDetailsSchema>;
