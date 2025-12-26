import { z } from "zod";
import { prStatusSchema, urgencyLevelSchema } from "./enums";

export const prSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.string(),
  pr_code: z.string(),
  urgency_level: urgencyLevelSchema,
  status: prStatusSchema.default("DRAFT"),
  remarks: z.string().nullable().optional(),
  user_id: z.string(),
  approved_by: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const prMaterialItemSchema = z.object({
  id: z.number().int().positive().optional(),
  pr_id: z.number().int(),
  material_id: z.string(),
  quantity: z.string(),
  required_date: z.date(),
  created_at: z.date().optional(),
});

export type PR = z.infer<typeof prSchema>;
export type PRMaterialItem = z.infer<typeof prMaterialItemSchema>;
