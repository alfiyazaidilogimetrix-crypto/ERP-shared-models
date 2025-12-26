import { z } from "zod";

export const categorySchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1),
  description: z.string().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Category = z.infer<typeof categorySchema>;
