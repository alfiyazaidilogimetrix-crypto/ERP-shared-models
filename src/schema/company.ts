import { z } from 'zod';

/**
 * Company Schema
 * Matches the 'company' model in Prisma
 */
export const companySchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1, 'Company name is required'),
  address: z.string().min(1, 'Address is required'),
  phone: z.array(z.string()).default([]),
  email: z.string().email('Invalid email format').nullable().optional(),
  gstin: z.string().nullable().optional(),
  state: z.string().nullable().optional(),
  state_code: z.string().nullable().optional(),
  pan: z.string().nullable().optional(),
  user_id: z.number().int().positive(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type Company = z.infer<typeof companySchema>;

/**
 * Create Company Schema
 * Used for creating new company profiles
 */
export const createCompanySchema = companySchema.omit({
  id: true,
  created_at: true,
  updated_at: true,
});

export type CreateCompany = z.infer<typeof createCompanySchema>;
