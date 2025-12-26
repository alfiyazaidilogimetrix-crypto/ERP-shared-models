import { z } from "zod";

export const roleSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1, "Role name is required"),
  description: z.string().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Role = z.infer<typeof roleSchema>;
