import { z } from 'zod';

import { supplyStatusSchema, supplyTypeSchema } from './enums';

// Base schemas
export const vendorSupplyManagementSchema = z.object({
  id: z.number().int().positive().optional(),
  vendor_id: z.number().int().positive(),
  supply_type: supplyTypeSchema,
  po_id: z.number().int().positive().nullable().optional(),
  amount: z.string().min(1), // Using string for precise decimal handling
  payment_terms: z.string().max(500).nullable().optional(),
  status: supplyStatusSchema.default('PENDING'),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const directSupplyConfigurationSchema = z.object({
  id: z.number().int().positive().optional(),
  supply_id: z.number().int().positive(),
  project_id: z.number().int().positive(),
  chainage_location: z.string().max(200).nullable().optional(),
  delivery_location: z.string().max(500).nullable().optional(),
  fob_destination: z.string().max(200).nullable().optional(),
});

export const inventorySupplyConfigurationSchema = z.object({
  id: z.number().int().positive().optional(),
  supply_id: z.number().int().positive(),
  warehouse_location: z.string().max(200).nullable().optional(),
  expected_delivery_date: z.date().nullable().optional(),
  batch_number: z.string().max(100).nullable().optional(),
  quality_check_status: z
    .enum(['ACCEPTED', 'REJECTED', 'PENDING', 'HOLD'])
    .nullable()
    .optional(),
});

// Types
export type VendorSupplyManagement = z.infer<
  typeof vendorSupplyManagementSchema
>;
export type DirectSupplyConfiguration = z.infer<
  typeof directSupplyConfigurationSchema
>;
export type InventorySupplyConfiguration = z.infer<
  typeof inventorySupplyConfigurationSchema
>;
