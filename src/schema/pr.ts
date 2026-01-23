import { z } from 'zod';
import { prStatusSchema, urgencyLevelSchema, prTypeSchema } from './enums';

// Base schemas
export const prSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  pr_code: z.string().min(1),
  pr_type: prTypeSchema.default('NONE'),
  urgency_level: urgencyLevelSchema,
  status: prStatusSchema.default('DRAFT'),
  remarks: z.string().nullable().optional(),
  user_id: z.number().int().positive().nullable().optional(),
  approved_by: z.number().int().positive().nullable().optional(),
  send_to: z.number().int().positive().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const prMaterialItemSchema = z.object({
  id: z.number().int().positive().optional(),
  pr_id: z.number().int().positive(),
  material_id: z.number().int().positive(),
  quantity: z.string().min(1), // Using string for precise decimal handling
  required_date: z.date(),
  is_approved: z.boolean().default(false),
  approved_qty: z.string().nullable().optional(),
  approval_remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

// Types
export type PR = z.infer<typeof prSchema>;
export type PRMaterialItem = z.infer<typeof prMaterialItemSchema>;
