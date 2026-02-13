import { z } from 'zod';
import { vendorStatusSchema, vendorTypeSchema } from './enums';

export const vendorSchema = z.object({
  id: z.number().int().positive().optional(),
  vendor_name: z.string().min(1).max(200),
  proprietor_name: z.string().optional().nullable(),
  contact_person: z.string().optional().nullable(),
  contact_number: z.string().min(10).max(15),
  email_address: z.string().email().nullable().optional(),
  address: z.string().min(1).max(500),
  registered_address: z.string().max(500).nullable().optional(),

  vendor_type: vendorTypeSchema.nullable().optional(),
  status: vendorStatusSchema.default('ACTIVE'),

  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const vendorBankDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  vendorId: z.number().int().positive(),

  bank_name: z.string().min(1).max(100),
  branch_name: z.string().max(100).nullable().optional(),
  bank_address: z.string().max(300).nullable().optional(),
  bank_contact_number: z.string().max(15).nullable().optional(),

  account_number: z.string().min(9).max(18),
  ifsc_code: z.string().min(1),
  micr_code: z
    .string()
    .regex(/^\d{9}$/)
    .nullable()
    .optional(),
  rtgs_code: z
    .string()
    .regex(/^[A-Z]{4}0[A-Z0-9]{6}$/)
    .nullable()
    .optional(),
  neft_code: z
    .string()
    .regex(/^[A-Z]{4}0[A-Z0-9]{6}$/)
    .nullable()
    .optional(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const vendorFinancialDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  vendorId: z.number().int().positive(),

  registration_number: z.string().max(50).nullable().optional(),
  pan_number: z.string().regex(/^[A-Z]{5}[0-9]{4}[A-Z]{1}$/),
  esi_number: z
    .string()
    .regex(/^\d{17}$/)
    .nullable()
    .optional(),
  pf_number: z
    .string()
    .regex(/^[A-Z]{2}[A-Z]{3}\d{7}[A-Z]{3}$/)
    .nullable()
    .optional(),
  gst_number: z
    .string()
    .regex(/^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/)
    .nullable()
    .optional(),
  gst_state: z.string().max(50).nullable().optional(),

  annual_turnover: z.string().max(50).nullable().optional(),
  audited_balance_years: z.string().max(100).nullable().optional(),
  yearly_work_capacity: z.string().max(100).nullable().optional(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const vendorOtherDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  vendorId: z.number().int().positive(),

  organization_type: z.string().max(100).nullable().optional(),
  total_team_size: z.string().max(50).nullable().optional(),
  plant_and_machinery: z.string().max(500).nullable().optional(),
  organization_chart: z.string().max(1000).nullable().optional(),

  interested_other_work: z.string().max(500).nullable().optional(),
  association_status: z.string().max(100).nullable().optional(),
  geographical_presence: z.string().max(500).nullable().optional(),
  major_clients: z.string().max(1000).nullable().optional(),

  sop_qap_signoff: z.string().max(100).nullable().optional(),
  sop_quality_manual: z.string().max(100).nullable().optional(),
  relative_experience: z.string().max(500).nullable().optional(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const vendorDocumentsSchema = z.object({
  id: z.number().int().positive().optional(),
  vendorId: z.number().int().positive(),
  file_id: z.number().int().positive().nullable().optional(),
  document_type: z.string().max(100).nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

// Types
export type Vendor = z.infer<typeof vendorSchema>;
export type VendorBankDetails = z.infer<typeof vendorBankDetailsSchema>;
export type VendorFinancialDetails = z.infer<
  typeof vendorFinancialDetailsSchema
>;
export type VendorOtherDetails = z.infer<typeof vendorOtherDetailsSchema>;
export type VendorDocuments = z.infer<typeof vendorDocumentsSchema>;
