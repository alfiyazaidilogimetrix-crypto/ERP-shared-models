import { z } from "zod";
import { poStatusSchema, transportModeSchema } from "./enums";

export const poSchema = z.object({
  id: z.number().int().positive().optional(),
  pr_id: z.number().int(),
  project_id: z.string(),
  vendor_id: z.string(),
  po_code: z.string(),
  po_date: z.date().default(() => new Date()),
  expected_delivery_date: z.date().nullable().optional(),
  transport_mode: transportModeSchema.nullable().optional(),
  total_amount: z.string(),
  po_status: poStatusSchema.default("DRAFT"),
  payment_terms: z.string().nullable().optional(),
  delivery_terms: z.string().nullable().optional(),
  shipping_address: z.string().nullable().optional(),
  billing_address: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const poOrderItemSchema = z.object({
  id: z.number().int().positive().optional(),
  po_id: z.number().int(),
  material_id: z.string(),
  quantity: z.string(),
  rate: z.string(),
  amount: z.string(),
  created_at: z.date().optional(),
});

export type PO = z.infer<typeof poSchema>;
export type POOrderItem = z.infer<typeof poOrderItemSchema>;
