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
  grn_id: z.number().int().positive(),
  material_id: z.number().int().positive(),
  ordered: z.number().int().nonnegative(),
  chainage: z.string().nullable().optional(),
  quality: z.string().nullable().optional(),
  accepted: z.number().int().nonnegative(),
  Rejected: z.number().int().nonnegative(),
  received: z.number().int().nonnegative(),
  created_at: z.date().optional(),
});

export type GRNMaterialReceipt = z.infer<typeof grnMaterialReceiptSchema>;

// GRN Schema
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
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type GRN = z.infer<typeof grnSchema>;

// For creating GRN (without auto-generated fields)
export const createGrnSchema = grnSchema
  .omit({
    id: true,
    created_at: true,
    updated_at: true,
  })
  .extend({
    material_receipts: z
      .array(
        grnMaterialReceiptSchema.omit({
          id: true,
          created_at: true,
        }),
      )
      .optional(),
  });

export type CreateGRN = z.infer<typeof createGrnSchema>;

// For updating GRN
export const updateGrnSchema = createGrnSchema.partial();

export type UpdateGRN = z.infer<typeof updateGrnSchema>;

// For creating GRN Material Receipt
export const createGrnMaterialReceiptSchema = grnMaterialReceiptSchema.omit({
  id: true,
  created_at: true,
});

export type CreateGRNMaterialReceipt = z.infer<
  typeof createGrnMaterialReceiptSchema
>;

// For updating GRN Material Receipt
export const updateGrnMaterialReceiptSchema =
  createGrnMaterialReceiptSchema.partial();

export type UpdateGRNMaterialReceipt = z.infer<
  typeof updateGrnMaterialReceiptSchema
>;
