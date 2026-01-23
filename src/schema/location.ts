import { z } from 'zod';

// Base schemas
export const locationSchema = z.object({
  id: z.number().int().positive().optional(),
  country: z.string().min(1).max(100),
  state: z.string().min(1).max(100),
  district: z.string().min(1).max(100),
  tehsil: z.string().max(100).nullable().optional(),
  village: z.string().max(100).nullable().optional(),
  address: z.string().min(1).max(500),
  pincode: z
    .string()
    .regex(/^\d{5,10}$/)
    .nullable()
    .optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

// Types
export type Location = z.infer<typeof locationSchema>;
