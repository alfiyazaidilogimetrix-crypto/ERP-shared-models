import { z } from 'zod';
import { poStatusSchema, transportModeSchema } from './enums';

// Base schemas without relationships
export const poBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  pr_id: z.number().int().positive(),
  project_id: z.number().int().positive(),
  vendor_id: z.number().int().positive(),
  po_code: z.string().min(1, 'PO code is required'),
  po_date: z.date().default(() => new Date()),
  expected_delivery_date: z.date().nullable().optional(),
  transport_mode: transportModeSchema.nullable().optional(),
  total_amount: z
    .string()
    .min(1, 'Total amount is required')
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) >= 0, {
      message: 'Total amount must be a valid number',
    }),
  po_status: poStatusSchema.default('DRAFT'),
  payment_terms: z.string().nullable().optional(),
  delivery_terms: z.string().nullable().optional(),
  shipping_address: z.string().nullable().optional(),
  billing_address: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const poOrderItemBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  po_id: z.number().int().positive(),
  material_id: z.number().int().positive(),
  quantity: z
    .string()
    .min(1, 'Quantity is required')
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) > 0, {
      message: 'Quantity must be a positive number',
    }),
  rate: z
    .string()
    .min(1, 'Rate is required')
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) >= 0, {
      message: 'Rate must be a valid number',
    }),
  amount: z
    .string()
    .min(1, 'Amount is required')
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) >= 0, {
      message: 'Amount must be a valid number',
    }),
  created_at: z.date().optional(),
});

// Full schemas with relationships
export const poSchema = poBaseSchema.extend({
  order_items: z.array(poOrderItemBaseSchema).optional(),
  pr: z.any().optional(), // PR type from previous schema
  project: z.any().optional(),
  vendor: z.any().optional(),
});

export const poOrderItemSchema = poOrderItemBaseSchema.extend({
  po: poBaseSchema.optional(),
  material: z.any().optional(),
});

// Create schemas (for form submissions)
export const createPOSchema = poBaseSchema
  .omit({
    id: true,
    po_status: true,
    total_amount: true, // Should be calculated from order items
    created_at: true,
    updated_at: true,
  })
  .extend({
    order_items: z
      .array(
        poOrderItemBaseSchema.omit({
          id: true,
          po_id: true,
          amount: true, // Should be calculated from quantity * rate
          created_at: true,
        }),
      )
      .min(1, 'At least one order item is required'),
  });

export const createPOOrderItemSchema = poOrderItemBaseSchema.omit({
  id: true,
  po_id: true,
  amount: true, // Should be calculated
  created_at: true,
});

// Update schemas
export const updatePOSchema = poBaseSchema.partial().extend({
  id: z.number().int().positive(),
});

export const updatePOOrderItemSchema = poOrderItemBaseSchema.partial().extend({
  id: z.number().int().positive(),
});

// Status update schema
export const updatePOStatusSchema = z.object({
  id: z.number().int().positive(),
  po_status: poStatusSchema,
  remarks: z.string().optional(),
});

// Validate amount calculation schema
export const validatePOAmountSchema = z
  .object({
    quantity: z.string(),
    rate: z.string(),
  })
  .transform((data) => {
    const quantity = parseFloat(data.quantity);
    const rate = parseFloat(data.rate);

    if (isNaN(quantity) || isNaN(rate)) {
      return { ...data, amount: '0' };
    }

    return {
      ...data,
      amount: (quantity * rate).toString(),
    };
  });

// Types
export type PO = z.infer<typeof poSchema>;
export type POOrderItem = z.infer<typeof poOrderItemSchema>;
export type CreatePO = z.infer<typeof createPOSchema>;
export type CreatePOOrderItem = z.infer<typeof createPOOrderItemSchema>;
export type UpdatePO = z.infer<typeof updatePOSchema>;
export type UpdatePOOrderItem = z.infer<typeof updatePOOrderItemSchema>;
export type UpdatePOStatus = z.infer<typeof updatePOStatusSchema>;
