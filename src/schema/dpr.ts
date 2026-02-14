import { z } from 'zod';
import { siteTypeSchema } from './enums';

// DPR Chainage Entry Schema
export const dprChainageSchema = z.object({
  id: z.number().int().positive().optional(),

  dpr_id: z.number().int().positive().optional(),

  site: siteTypeSchema,

  chainage: z.string().min(1),

  category: z.string().min(1),

  activity_id: z.number().int().positive(),

  sub_activity_id: z.number().int().positive(),

  number: z.number().int(),

  length: z.number().int(),

  width: z.number().int(),

  depth: z.number().int(),

  unit_id: z.number().int().positive(),

  quantity: z.number().int(),

  plan_quantity: z.number().int(),

  created_at: z.date().optional(),

  updated_at: z.date().optional(),
});

export type DPRChainage = z.infer<typeof dprChainageSchema>;
export const dprFileSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export type DPRFile = z.infer<typeof dprFileSchema>;

export const dprSchema = z.object({
  id: z.number().int().positive().optional(),

  date: z.date().or(z.string().pipe(z.coerce.date())),

  project_id: z.number().int().positive(),

  submitted_by: z.number().int().positive(),

  entries: z.array(dprChainageSchema).min(1),

  dprfiles: z.array(dprFileSchema).optional(),

  created_at: z.date().optional(),

  updated_at: z.date().optional(),
});

export type DPR = z.infer<typeof dprSchema>;
