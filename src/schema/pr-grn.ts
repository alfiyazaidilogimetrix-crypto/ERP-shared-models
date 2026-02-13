import { z } from 'zod';
import { receiptStatusSchema, transportModeSchema } from './enums';

// PRGRN Material Receipt Schema
export const prgrnMaterialReceiptSchema = z.object({
  id: z.number().int().positive().optional(),
  grn_id: z.number().int().positive().optional(),
  material_id: z.number().int().positive(),
  ordered: z.number().int().nonnegative(),
  chainage: z.string().nullable().optional(),
  quality: z.string().nullable().optional(),
  accepted: z.number().int().nonnegative(),
  rejected: z.number().int().nonnegative(),
  received: z.number().int().nonnegative(),
  created_at: z.date().optional(),
});

export type PRGRNMaterialReceipt = z.infer<typeof prgrnMaterialReceiptSchema>;

// PRGRN File Schema
export const prgrnFileSchema = z.object({
  id: z.number().int().positive().optional(),
  grn_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export type PRGRNFile = z.infer<typeof prgrnFileSchema>;

// Base PRGRN Schema (for reading/updating)
export const prgrnSchema = z.object({
  id: z.number().int().positive().optional(),
  pr_id: z.number().int().positive(),
  gate_entry_number: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  driver_name: z.string().nullable().optional(),
  driver_contact: z.string().nullable().optional(),
  transport_mode: transportModeSchema.nullable().optional(),
  status: receiptStatusSchema,
  received_date: z.date().or(z.string().pipe(z.coerce.date())),
  received_time: z.string().nullable().optional(),
  quality_check_completed: z.boolean().default(false),
  grn_remarks: z.string().nullable().optional(),
  created_by_id: z.number().int().positive().nullable().optional(),
  material_receipts: z.array(prgrnMaterialReceiptSchema).optional(),
  grnfiles: z.array(prgrnFileSchema).optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type PRGRN = z.infer<typeof prgrnSchema>;

// Create PRGRN Schema (for creating new PRGRN)
export const createPrgrnSchema = prgrnSchema.omit({
  id: true,
  created_at: true,
  updated_at: true,
});

export type CreatePRGRN = z.infer<typeof createPrgrnSchema>;
