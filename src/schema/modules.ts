import { z } from "zod";

export const moduleSchema = z.object({
  id: z.number().int().positive().optional(),
  Name: z.string().min(1, "Module name is required"),
  description: z.string().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Module = z.infer<typeof moduleSchema>;
