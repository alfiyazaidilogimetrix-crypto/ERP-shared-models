import { z } from "zod";
import { transportModeSchema, receiptStatusSchema } from "./enums";

export const grnSchema = z.object({
  id: z.number().int().positive().optional(),
  po_id: z.number().int(),
  gate_entry_number: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  driver_name: z.string().nullable().optional(),
  driver_contact: z.string().nullable().optional(),
  transport_mode: transportModeSchema.nullable().optional(),
  received_date: z.date(),
  received_time: z.date().nullable().optional(),
  store_location: z.string().nullable().optional(),
  quality_check_completed: z.boolean().default(false),
  grn_remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const grnMaterialReceiptSchema = z.object({
  id: z.number().int().positive().optional(),
  grn_id: z.number().int(),
  material_id: z.string(),
  ordered: z.string(),
  status: receiptStatusSchema,
  chainage: z.string().nullable().optional(),
  quality: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

export type GRN = z.infer<typeof grnSchema>;
export type GRNMaterialReceipt = z.infer<typeof grnMaterialReceiptSchema>;
