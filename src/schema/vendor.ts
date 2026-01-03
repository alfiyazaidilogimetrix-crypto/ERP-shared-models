import { z } from 'zod';

// Vendor Status Enum Schema
export const vendorStatusSchema = z.enum(['ACTIVE', 'INACTIVE', 'SUSPENDED']);

// Vendor Type Enum Schema (if needed elsewhere)
export const vendorTypeSchema = z.enum(['DIRECT', 'INVENTORY']);

// Supply Status Enum Schema (if needed elsewhere)
export const supplyStatusSchema = z.enum([
  'PENDING',
  'APPROVED',
  'IN_TRANSIT',
  'DELIVERED',
  'REJECTED',
]);

// Main Vendor Schema
export const vendorSchema = z.object({
  id: z.number().int().positive().optional(),
  vendor_name: z.string().min(1, 'Vendor name is required'),
  category_id: z
    .number()
    .int()
    .positive('Category ID must be a positive integer'),
  category: z.string().nullable().optional(), // Optional for display purposes
  contact_number: z.string().nullable().optional(),
  email_address: z
    .string()
    .email('Invalid email address')
    .nullable()
    .optional(),
  address: z.string().nullable().optional(),
  gst_number: z.string().nullable().optional(),
  pan_number: z.string().nullable().optional(),
  status: vendorStatusSchema.default('ACTIVE'),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

// Type definitions
export type Vendor = z.infer<typeof vendorSchema>;
