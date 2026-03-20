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

  category_id: z.number().int().positive(),
  activity_id: z.number().int().positive(),
  material_id: z.number().int().positive().nullable().optional(),

  number: z.number().int().nullable().optional(),

  length: z.number().int().nullable().optional(),

  width: z.number().int().nullable().optional(),

  depth: z.number().int().nullable().optional(),

  unit_id: z.number().int().positive(),

  quantity: z.number().int().nullable().optional(),

  plan_quantity: z.number().int().nullable().optional(),
  work_description: z.string().nullable().optional(),
  boq_rate: z.number().int().nullable().optional(),
  amount: z.number().int().nullable().optional(),
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

  entries: z.array(dprChainageSchema).min(1),
  created_at: z.date().optional(),

  updated_at: z.date().optional(),
});

export type DPR = z.infer<typeof dprSchema>;
