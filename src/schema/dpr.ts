import { z } from 'zod';
import { siteTypeSchema } from './enums';

export const dprFileSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export type DPRFile = z.infer<typeof dprFileSchema>;
// DPR Chainage Entry Schema
export const dprChainageSchema = z.object({
  id: z.number().int().positive().optional(),

  dpr_id: z.number().int().positive().optional(),

  site: siteTypeSchema.nullable().optional(),

  chainage_from: z.string().nullable().optional(),

  chainage_to: z.string().nullable().optional(),

  category_id: z.number().int().positive().optional(),
  activity_id: z.number().int().positive().optional(),
  material_id: z.number().int().positive().nullable().optional(),

  number: z.number().nullable().optional(),
  length: z.number().nullable().optional(),
  width: z.number().nullable().optional(),
  depth: z.number().nullable().optional(),

  unit_id: z.number().int().positive().optional(),

  quantity: z.number().nullable().optional(),

  plan_quantity: z.number().nullable().optional(),
  work_description: z.string().nullable().optional(),
  boq_rate: z.number().nullable().optional(),
  amount: z.number().nullable().optional(),
  dprfiles: z.array(dprFileSchema).optional(),

  created_at: z.date().optional(),

  updated_at: z.date().optional(),
});

export type DPRChainage = z.infer<typeof dprChainageSchema>;

export const dprSchema = z.object({
  id: z.number().int().positive().optional(),

  date: z.date().or(z.string().pipe(z.coerce.date())),

  project_id: z.number().int().positive(),

  submitted_by: z.number().int().positive(),
  company_id: z.number().int().positive(),
  head_office_id: z.number().int().positive(),
  branch_office_id: z.number().int().positive(),

  entries: z.array(dprChainageSchema).min(1),
  created_at: z.date().optional(),

  updated_at: z.date().optional(),
});

export type DPR = z.infer<typeof dprSchema>;
