import { z } from "zod";
import { vendorTypeSchema, supplyStatusSchema } from "./enums";

export const vendorSupplyManagementSchema = z.object({
  id: z.number().int().positive().optional(),
  vendor_type: vendorTypeSchema,
  vendor_id: z.number().int(),
  material_id: z.number().int(),
  quantity: z.string(),
  unit: z.string(),
  amount: z.string(),
  payment_terms: z.string().nullable().optional(),
  status: supplyStatusSchema.default("PENDING"),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const directSupplyConfigurationSchema = z.object({
  id: z.number().int().positive().optional(),
  supply_id: z.number().int(),
  project_id: z.number().int(),
  chainage_location: z.string().nullable().optional(),
  delivery_location: z.string().nullable().optional(),
  fob_destination: z.string().nullable().optional(),
});

export const inventorySupplyConfigurationSchema = z.object({
  id: z.number().int().positive().optional(),
  supply_id: z.number().int(),
  warehouse_location: z.string().nullable().optional(),
  expected_delivery_date: z.date().nullable().optional(),
  batch_number: z.string().nullable().optional(),
  quality_check_status: z.string().nullable().optional(),
});

export type VendorSupplyManagement = z.infer<typeof vendorSupplyManagementSchema>;
export type DirectSupplyConfiguration = z.infer<typeof directSupplyConfigurationSchema>;
export type InventorySupplyConfiguration = z.infer<typeof inventorySupplyConfigurationSchema>;
