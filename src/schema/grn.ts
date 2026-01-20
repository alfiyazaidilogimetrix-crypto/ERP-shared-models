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
  rejected: z.number().int().nonnegative(), // Fixed: lowercase 'rejected' to match Prisma model
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

// // Create GRN Schema (for creating new GRN with file_ids)
// export const createGrnSchema = z.object({
//   po_id: z.number().int().positive(),
//   gate_entry_number: z.string().nullable().optional(),
//   vehicle_number: z.string().nullable().optional(),
//   driver_name: z.string().nullable().optional(),
//   driver_contact: z.string().nullable().optional(),
//   transport_mode: TransportMode.nullable().optional(),
//   status: ReceiptStatus.default('PENDING'),
//   received_date: z.date().or(z.string().pipe(z.coerce.date())),
//   received_time: z.string().nullable().optional(),
//   store_location: z.string().nullable().optional(),
//   quality_check_completed: z.boolean().default(false),
//   grn_remarks: z.string().nullable().optional(),
//   material_receipts: z.array(grnMaterialReceiptSchema.omit({ grn_id: true })),
//   file_ids: z.array(z.number().int().positive()).optional().default([]),
// });

// export type CreateGRNInput = z.infer<typeof createGrnSchema>;

// // Update GRN Schema
// export const updateGrnSchema = z.object({
//   gate_entry_number: z.string().nullable().optional(),
//   vehicle_number: z.string().nullable().optional(),
//   driver_name: z.string().nullable().optional(),
//   driver_contact: z.string().nullable().optional(),
//   transport_mode: TransportMode.nullable().optional(),
//   status: ReceiptStatus.optional(),
//   received_date: z.date().or(z.string().pipe(z.coerce.date())).optional(),
//   received_time: z.string().nullable().optional(),
//   store_location: z.string().nullable().optional(),
//   quality_check_completed: z.boolean().optional(),
//   grn_remarks: z.string().nullable().optional(),
//   material_receipts: z.array(grnMaterialReceiptSchema).optional(),
//   file_ids: z.array(z.number().int().positive()).optional(),
// });

// export type UpdateGRNInput = z.infer<typeof updateGrnSchema>;

// // GRN with relations Schema (for responses)
// export const grnWithRelationsSchema = grnSchema.extend({
//   material_receipts: z.array(grnMaterialReceiptSchema),
//   grnfiles: z.array(
//     grnFileSchema.extend({
//       file: z
//         .object({
//           id: z.number().int().positive(),
//           filename: z.string(),
//           url: z.string(),
//           mimetype: z.string(),
//           size: z.number().int(),
//           created_at: z.date(),
//         })
//         .optional(),
//     }),
//   ),
//   purchase_order: z
//     .object({
//       id: z.number().int().positive(),
//       po_number: z.string(),
//       // Add other PO fields as needed
//     })
//     .optional(),
// });

// export type GRNWithRelations = z.infer<typeof grnWithRelationsSchema>;
