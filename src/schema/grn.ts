import { z } from 'zod';
import { receiptStatusSchema, transportModeSchema } from './enums';

// GRN Material Receipt Schema
export const grnMaterialReceiptSchema = z.object({
  id: z.number().int().positive().optional(),
  grn_id: z.number().int().positive().optional(),
  material_id: z.number().int().positive(),
  ordered: z.number().int().nonnegative(),
  chainage: z.string().nullable().optional(),
  quality: z.string().nullable().optional(),
  rejected: z.number().int().nonnegative(),
  received: z.number().int().nonnegative(),
  rate: z.number().int().nonnegative().optional().nullable(),
  amount: z.number().int().nonnegative().optional().nullable(),
  quantity: z.number().int().nonnegative().optional().nullable(),
  hsn_no: z.string().optional().nullable(),
  created_at: z.date().optional(),
});

export type GRNMaterialReceipt = z.infer<typeof grnMaterialReceiptSchema>;

// GRN File Schema
export const grnFileSchema = z.object({
  id: z.number().int().positive().optional(),
  grn_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export type GRNFile = z.infer<typeof grnFileSchema>;

// Base GRN Schema (for reading/updating)
export const grnSchema = z.object({
  id: z.number().int().positive().optional(),
  po_id: z.number().int().positive(),
  gate_entry_number: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  driver_name: z.string().nullable().optional(),
  driver_contact: z.string().nullable().optional(),
  transport_mode: transportModeSchema.nullable().optional(),
  status: receiptStatusSchema,
  received_date: z.date().or(z.string().pipe(z.coerce.date())),
  received_time: z.string().nullable().optional(),
  warehouse_id: z.number().int().positive().optional(),
  quality_check_completed: z.boolean().default(false),
  grn_remarks: z.string().nullable().optional(),
  total_amount: z.number().int().nonnegative().optional().nullable(),
  total_qty: z.number().int().nonnegative().optional().nullable(),
  total_rejected: z.number().int().nonnegative().optional().nullable(),
  total_received: z.number().int().nonnegative().optional().nullable(),
  grn_number: z.string().optional().nullable(),
  company_id: z.number().int().positive(),
  head_office_id: z.number().int().positive(),
  branch_office_id: z.number().int().positive(),
  created_by_id: z.number().int().positive().nullable().optional(),
  material_receipts: z.array(grnMaterialReceiptSchema).optional(),
  grnfiles: z.array(grnFileSchema).optional(),
  invoices: z.array(z.any()).optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type GRN = z.infer<typeof grnSchema>;
