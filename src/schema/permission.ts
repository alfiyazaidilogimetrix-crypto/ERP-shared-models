import { z } from "zod";

export const permissionSchema = z.object({
  id: z.number().int().positive().optional(),
  action: z.array(z.string()),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Permission = z.infer<typeof permissionSchema>;
