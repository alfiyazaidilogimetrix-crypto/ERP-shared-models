import { z } from 'zod';
import { siteTypeSchema } from './enums';

// DPR File Schema
export const dprFileSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export type DPRFile = z.infer<typeof dprFileSchema>;

// Base DPR Schema (matches current Prisma model)
export const dprSchema = z.object({
  id: z.number().int().positive().optional(),
  date: z.date().or(z.string().pipe(z.coerce.date())),
  project_id: z.number().int().positive(),
  site: siteTypeSchema,
  chainage: z.array(z.string()),
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
  submitted_by: z.number().int().positive(),
  dprfiles: z.array(dprFileSchema).optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type DPR = z.infer<typeof dprSchema>;
