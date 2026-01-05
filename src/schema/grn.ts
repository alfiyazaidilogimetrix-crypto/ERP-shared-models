import { z } from 'zod';
import { transportModeSchema, receiptStatusSchema } from './enums';

// Base schemas without relationships
export const grnBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  po_id: z.number().int().positive(),
  gate_entry_number: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  driver_name: z.string().nullable().optional(),
  driver_contact: z.string().nullable().optional(),
  transport_mode: transportModeSchema.nullable().optional(),
  received_date: z.date(),
  received_time: z.string().optional(), // Changed to optional string
  store_location: z.string().nullable().optional(),
  quality_check_completed: z.boolean().default(false),
  grn_remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const grnMaterialReceiptBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  grn_id: z.number().int().positive(),
  material_id: z.number().int().positive(),
  ordered: z
    .string()
    .min(1, 'Ordered quantity is required')
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) > 0, {
      message: 'Ordered quantity must be a positive number',
    }),
  status: receiptStatusSchema,
  chainage: z.string().nullable().optional(),
  quality: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

// Full schemas with relationships
export const grnSchema = grnBaseSchema.extend({
  material_receipts: z.array(grnMaterialReceiptBaseSchema).optional(),
  purchase_order: z.any().optional(), // PO type from previous schema
});

export const grnMaterialReceiptSchema = grnMaterialReceiptBaseSchema.extend({
  grn: grnBaseSchema.optional(),
  material: z.any().optional(),
});

// Create schemas (for form submissions)
export const createGRNSchema = grnBaseSchema
  .omit({
    id: true,
    quality_check_completed: true, // Defaults to false
    created_at: true,
    updated_at: true,
  })
  .extend({
    material_receipts: z
      .array(
        grnMaterialReceiptBaseSchema.omit({
          id: true,
          grn_id: true,
          created_at: true,
        }),
      )
      .min(1, 'At least one material receipt is required'),
  });

export const createGRNMaterialReceiptSchema = grnMaterialReceiptBaseSchema.omit(
  {
    id: true,
    grn_id: true,
    created_at: true,
  },
);

// Update schemas
export const updateGRNSchema = grnBaseSchema.partial().extend({
  id: z.number().int().positive(),
});

export const updateGRNMaterialReceiptSchema = grnMaterialReceiptBaseSchema
  .partial()
  .extend({
    id: z.number().int().positive(),
  });

// Quality check update schema
export const updateGRNQualityCheckSchema = z.object({
  id: z.number().int().positive(),
  quality_check_completed: z.boolean(),
  grn_remarks: z.string().optional(),
});

// Material receipt status update schema
export const updateMaterialReceiptStatusSchema = z.object({
  id: z.number().int().positive(),
  status: receiptStatusSchema,
  quality: z.string().optional(),
  chainage: z.string().optional(),
  remarks: z.string().optional(),
});

// Combined date/time schema for forms (since forms often handle date/time separately)
export const grnDateTimeBaseSchema = z.object({
  received_date: z.string().refine((val) => !isNaN(Date.parse(val)), {
    message: 'Invalid date format',
  }),
  received_time: z.string().optional(), // Optional string (not nullable)
});

export const grnDateTimeSchema = grnDateTimeBaseSchema.transform((data) => {
  let receivedDate = new Date(data.received_date);

  if (data.received_time && data.received_time.trim() !== '') {
    const [hours, minutes] = data.received_time.split(':').map(Number);
    if (!isNaN(hours) && !isNaN(minutes)) {
      receivedDate.setHours(hours, minutes, 0, 0);
    }
  } else {
    receivedDate.setHours(0, 0, 0, 0);
  }

  return {
    received_date: receivedDate,
    received_time: data.received_time?.trim() || undefined, // Return as undefined if empty
  };
});

// Combined create GRN schema for forms
export const createGRNFormSchema = createGRNSchema
  .omit({
    received_date: true,
    received_time: true,
  })
  .extend({
    ...grnDateTimeBaseSchema.shape,
    material_receipts: createGRNSchema.shape.material_receipts,
  });

// Types
export type GRN = z.infer<typeof grnSchema>;
export type GRNMaterialReceipt = z.infer<typeof grnMaterialReceiptSchema>;
export type CreateGRN = z.infer<typeof createGRNSchema>;
export type CreateGRNForm = z.infer<typeof createGRNFormSchema>;
export type CreateGRNMaterialReceipt = z.infer<
  typeof createGRNMaterialReceiptSchema
>;
export type UpdateGRN = z.infer<typeof updateGRNSchema>;
export type UpdateGRNMaterialReceipt = z.infer<
  typeof updateGRNMaterialReceiptSchema
>;
export type UpdateGRNQualityCheck = z.infer<typeof updateGRNQualityCheckSchema>;
export type UpdateMaterialReceiptStatus = z.infer<
  typeof updateMaterialReceiptStatusSchema
>;
