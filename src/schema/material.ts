import { z } from "zod";

export const materialSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1),
  material_code: z.string().nullable().optional(),
  categoryId: z.number().int().nullable().optional(),
  unitId: z.number().int().nullable().optional(),
  status: z.string().default("active"),
  minimum_threshold_quantity: z.number().int().nullable().optional(),
  unit_of_measure: z.string().nullable().optional(),
  specifications: z.string().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Material = z.infer<typeof materialSchema>;
