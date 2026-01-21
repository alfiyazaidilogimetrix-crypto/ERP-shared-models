import { z } from 'zod';

// Enums
export const ReceiptStatus = z.enum([
  'RECEIVED',
  'ACCEPTED',
  'REJECTED',
  'PARTIALLY_ACCEPTED',
  'PENDING',
]);

export const TransportMode = z.enum([
  'ROAD',
  'RAIL',
  'SEA',
  'AIR',
  'SELF_PICKUP',
]);

export type ReceiptStatus = z.infer<typeof ReceiptStatus>;
export type TransportMode = z.infer<typeof TransportMode>;

// GRN Material Receipt Schema
export const grnMaterialReceiptSchema = z.object({
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
  transport_mode: TransportMode.nullable().optional(),
  status: ReceiptStatus,
  received_date: z.date().or(z.string().pipe(z.coerce.date())),
  received_time: z.string().nullable().optional(),
  store_location: z.string().nullable().optional(),
  quality_check_completed: z.boolean().default(false),
  grn_remarks: z.string().nullable().optional(),
  material_receipts: z.array(grnMaterialReceiptSchema).optional(),
  grnfiles: z.array(grnFileSchema).optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type GRN = z.infer<typeof grnSchema>;
