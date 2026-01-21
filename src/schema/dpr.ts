import { z } from 'zod';

// DPR Material Consumption Schema
export const dprMaterialConsumptionSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  stock_id: z.number().int().positive(),
  quantity: z.number().nonnegative(),
  unit: z.string(),
  rate: z.number().nonnegative(),
  amount: z.number().nonnegative(),
  chainage_from: z.string().nullable().optional(),
  chainage_to: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

export type DPRMaterialConsumption = z.infer<
  typeof dprMaterialConsumptionSchema
>;

// DPR Labour Schema (for linking labour to DPRLabourConsumption)
export const dprLabourSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_labour_consumption_id: z.number().int().positive().optional(),
  labour_id: z.number().int().positive(),
});

export type DPRLabour = z.infer<typeof dprLabourSchema>;

// DPR Labour Consumption Schema
export const dprLabourConsumptionSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  skill: z.string(),
  hours: z.number().nonnegative(),
  charges: z.number().nonnegative(),
  chainage_from: z.string().nullable().optional(),
  chainage_to: z.string().nullable().optional(),
  labours: z
    .array(dprLabourSchema.omit({ dpr_labour_consumption_id: true }))
    .optional(),
  created_at: z.date().optional(),
});

export type DPRLabourConsumption = z.infer<typeof dprLabourConsumptionSchema>;

// DPR Machinery Usage Schema
export const dprMachineryUsageSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  machine_code: z.string().nullable().optional(),
  machine_name: z.string(),
  chainage_from: z.string().nullable().optional(),
  chainage_to: z.string().nullable().optional(),
  working_hours: z.number().nonnegative(),
  fuel_type: z.string().nullable().optional(),
  fuel_consumed: z.string().nullable().optional(),
  fuel_amount: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

export type DPRMachineryUsage = z.infer<typeof dprMachineryUsageSchema>;

// DPR File Schema
export const dprFileSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export type DPRFile = z.infer<typeof dprFileSchema>;

// Base DPR Schema (for reading/updating)
export const dprSchema = z.object({
  id: z.number().int().positive().optional(),
  date: z.date().or(z.string().pipe(z.coerce.date())),
  project_id: z.number().int().positive(),
  weather_conditions: z.string(),
  safety_incidents: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  submitted_by: z.number().int().positive(),
  material_cost: z.number().nonnegative(),
  labour_cost: z.number().nonnegative(),
  machinery_cost: z.number().nonnegative(),
  total_cost: z.number().nonnegative(),
  materials: z.array(dprMaterialConsumptionSchema).optional(),
  labours: z.array(dprLabourConsumptionSchema).optional(),
  machinery: z.array(dprMachineryUsageSchema).optional(),
  dprfiles: z.array(dprFileSchema).optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type DPR = z.infer<typeof dprSchema>;
