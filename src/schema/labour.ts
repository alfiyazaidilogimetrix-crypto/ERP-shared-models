import { z } from "zod";
import { labourStatusSchema, labourTypeSchema } from "./enums";

export const labourSchema = z.object({
  id: z.number().int().positive().optional(),
  labour_name: z.string().min(1),
  labour_code: z.string().min(1),
  labour_type: labourTypeSchema,
  skill: z.string(),
  phone_number: z.string().nullable().optional(),
  aadhar_number: z.string().nullable().optional(),
  address: z.string().nullable().optional(),
  joining_date: z.date().nullable().optional(),
  status: labourStatusSchema.default("ACTIVE"),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type Labour = z.infer<typeof labourSchema>;
