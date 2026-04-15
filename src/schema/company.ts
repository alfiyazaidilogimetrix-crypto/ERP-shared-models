import { z } from 'zod';

/**
 * Company Schema
 * Matches the 'company' model in Prisma
 */
export const companySchema = z.object({
  id: z.number().int().positive().optional(),
  company_name: z.string().min(1, 'Company name is required'),
  pincode: z.string().min(1, 'Pincode is required'),
  state: z.string().min(1, 'State is required'),
  district: z.string().min(1, 'District is required'),
  address: z.string().min(1, 'Address is required'),
  company_mail_id: z.string().email('Invalid email format'),
  company_phone_number: z.string().min(1, 'Phone number is required'),
  company_gst_number: z.string().min(1, 'GST number is required'),
  business_type: z.string().min(1, 'Business type is required'),
  file_id: z.number().int().nullable().optional(),
  user_id: z.number().int().positive(),
  owner_id: z.number().int().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type Company = z.infer<typeof companySchema>;

/**
 * Owner Details Schema
 * Matches the 'owner_details' model in Prisma
 */
export const ownerDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  owner_name: z.string().min(1, 'Owner name is required'),
  owner_father_name: z.string().min(1, 'Father name is required'),
  dob: z.coerce.date(),
  pincode: z.string().min(1, 'Pincode is required'),
  state: z.string().min(1, 'State is required'),
  district: z.string().min(1, 'District is required'),
  address: z.string().min(1, 'Address is required'),
  owner_phone_number: z.string().min(1, 'Phone number is required'),
  owner_mail_id: z.string().email('Invalid email format'),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type OwnerDetails = z.infer<typeof ownerDetailsSchema>;

/**
 * Company Files Schema
 * Matches the 'company_files' model in Prisma
 */
export const companyFilesSchema = z.object({
  id: z.number().int().positive().optional(),
  company_id: z.number().int().positive(),
  file_id: z.number().int().positive(),
  file_type: z.string().min(1, 'File type is required'),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type CompanyFiles = z.infer<typeof companyFilesSchema>;

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

