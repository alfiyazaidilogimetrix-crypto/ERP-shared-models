import { z } from "zod";
import { vendorStatusSchema } from "./enums";

export const vendorSchema = z.object({
  id: z.number().int().positive().optional(),
  vendor_name: z.string().min(1),
  category: z.string().nullable().optional(),
  contact_number: z.string().nullable().optional(),
  email_address: z.string().email().nullable().optional(),
  address: z.string().nullable().optional(),
  gst_number: z.string().nullable().optional(),
  pan_number: z.string().nullable().optional(),
  payment_terms: z.string().nullable().optional(),
  status: vendorStatusSchema.default("ACTIVE"),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type Vendor = z.infer<typeof vendorSchema>;
