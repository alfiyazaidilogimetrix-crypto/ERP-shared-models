import { z } from 'zod';
import { workOrderStatusSchema, paymentStatusSchema } from './enums';

// Base schema without relationships
export const subContractorWorkOrderBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  vendor_id: z.number().int().positive(),
  materia_boq_id: z.number().int().positive(),
  work_order_no: z.string().min(1, 'Work order number is required'),
  work_order_date: z.date(),
  work_order_status: workOrderStatusSchema.nullable().optional(),
  work_order_description: z.string().nullable().optional(),
  work_order_amount: z.string().nullable().optional(),
  payment_status: paymentStatusSchema.default('PENDING'),
  meta_data: z.any().nullable().optional(),
  company_id: z.number().int().positive(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
  workOrderItems: z.array(z.any()).optional(),
});

// Full schema with relationships
export const subContractorWorkOrderSchema = subContractorWorkOrderBaseSchema.extend({
  project: z.any().optional(),
  vendor: z.any().optional(),
  material_boq: z.any().optional(),
});

// Create schema (for form submissions)
export const createSubContractorWorkOrderSchema = subContractorWorkOrderBaseSchema.omit({
  id: true,
  created_at: true,
  updated_at: true,
});

// Update schema
export const updateSubContractorWorkOrderSchema = subContractorWorkOrderBaseSchema.partial().extend({
  id: z.number().int().positive(),
});

// Types
export type SubContractorWorkOrder = z.infer<typeof subContractorWorkOrderSchema>;
export type CreateSubContractorWorkOrder = z.infer<typeof createSubContractorWorkOrderSchema>;
export type UpdateSubContractorWorkOrder = z.infer<typeof updateSubContractorWorkOrderSchema>;
