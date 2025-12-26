import { z } from "zod";
import { dieselTransactionTypeSchema } from "./enums";

export const dieselTransactionSchema = z.object({
  id: z.number().int().positive().optional(),
  transaction_type: dieselTransactionTypeSchema,
  date: z.date(),
  project_id: z.string(),
  vendor_id: z.string().nullable().optional(),
  invoice_number: z.string().nullable().optional(),
  quantity: z.string().nullable().optional(),
  rate_per_litre: z.string().nullable().optional(),
  total_amount: z.string().nullable().optional(),
  equipment_name: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  purpose: z.string().nullable().optional(),
  issue_rate_per_litre: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type DieselTransaction = z.infer<typeof dieselTransactionSchema>;
