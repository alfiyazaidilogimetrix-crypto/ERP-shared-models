import { z } from "zod";

export const dprSchema = z.object({
  id: z.number().int().positive().optional(),
  date: z.date(),
  project_id: z.string(),
  weather_condition: z.string().nullable().optional(),
  skilled_workers: z.number().int().nullable().optional(),
  unskilled_workers: z.number().int().nullable().optional(),
  contractor_name: z.string().nullable().optional(),
  safety_incidents: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  submitted_by: z.string(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const dprWorkActivitySchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int(),
  activity_description: z.string(),
  chainage: z.string().nullable().optional(),
  planned_qty: z.string().nullable().optional(),
  actual_qty: z.string().nullable().optional(),
  progress: z.number().int().min(0).max(100).nullable().optional(),
  created_at: z.date().optional(),
});

export const dprMaterialConsumptionSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int(),
  material_id: z.string(),
  quantity: z.string(),
  chainage: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

export const dprMachineryUsageSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int(),
  equipment_name: z.string(),
  working_hours: z.string().nullable().optional(),
  idle_hours: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

export type DPR = z.infer<typeof dprSchema>;
export type DPRWorkActivity = z.infer<typeof dprWorkActivitySchema>;
export type DPRMaterialConsumption = z.infer<typeof dprMaterialConsumptionSchema>;
export type DPRMachineryUsage = z.infer<typeof dprMachineryUsageSchema>;
