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
  status: receiptStatusSchema, // Added missing status field
  received_date: z.date(),
  received_time: z.string().nullable().optional(), // Changed to nullable
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
  ordered: z.number().int().positive(), // Changed from string to number
  chainage: z.string().nullable().optional(),
  quality: z.string().nullable().optional(),
  accepted: z.number().int().min(0), // Added from Prisma schema
  Rejected: z.number().int().min(0), // Added from Prisma schema (Note: capital R)
  received: z.number().int().min(0), // Added from Prisma schema
  created_at: z.date().optional(),
});

// Fixed: Removed incorrect fields that don't exist in Prisma schema
// status, remarks don't exist in GRNMaterialReceipt model

// Full schemas with relationships
export const grnSchema = grnBaseSchema.extend({
  material_receipts: z.array(grnMaterialReceiptBaseSchema).optional(),
  purchase_order: z.any().optional(),
});

export const grnMaterialReceiptSchema = grnMaterialReceiptBaseSchema.extend({
  grn: grnBaseSchema.optional(),
  material: z.any().optional(),
});

// Create schemas (for form submissions)
export const createGRNSchema = grnBaseSchema
  .omit({
    id: true,
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

// Create GRN Material Receipt schema - simplified version for forms
export const createGRNMaterialReceiptSchema = z.object({
  material_id: z.number().int().positive(),
  ordered: z
    .string()
    .min(1, 'Ordered quantity is required')
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) > 0, {
      message: 'Ordered quantity must be a positive number',
    }),
  chainage: z.string().optional().nullable(),
  quality: z.string().optional().nullable(),
  accepted: z
    .string()
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) >= 0, {
      message: 'Accepted quantity must be a non-negative number',
    })
    .default('0'),
  Rejected: z
    .string()
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) >= 0, {
      message: 'Rejected quantity must be a non-negative number',
    })
    .default('0'),
  received: z
    .string()
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) >= 0, {
      message: 'Received quantity must be a non-negative number',
    })
    .default('0'),
});

// Form version that transforms string inputs to numbers
export const createGRNMaterialReceiptFormSchema =
  createGRNMaterialReceiptSchema.transform((data) => ({
    ...data,
    ordered: parseInt(data.ordered),
    accepted: parseInt(data.accepted),
    Rejected: parseInt(data.Rejected),
    received: parseInt(data.received),
  }));

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
  grn_remarks: z.string().optional().nullable(),
});

// Material receipt update schema (replaces old status update schema)
export const updateMaterialReceiptSchema = z.object({
  id: z.number().int().positive(),
  accepted: z.number().int().min(0).optional(),
  Rejected: z.number().int().min(0).optional(),
  received: z.number().int().min(0).optional(),
  quality: z.string().optional().nullable(),
  chainage: z.string().optional().nullable(),
});

// Combined date/time schema for forms
export const grnDateTimeBaseSchema = z.object({
  received_date: z.string().refine((val) => !isNaN(Date.parse(val)), {
    message: 'Invalid date format',
  }),
  received_time: z.string().optional().nullable(),
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
    received_time: data.received_time?.trim() || null, // Return null if empty
  };
});

// Create GRN form schema
export const createGRNFormSchema = z.object({
  po_id: z.number().int().positive(),
  gate_entry_number: z.string().optional().nullable(),
  vehicle_number: z.string().optional().nullable(),
  driver_name: z.string().optional().nullable(),
  driver_contact: z.string().optional().nullable(),
  transport_mode: transportModeSchema.optional().nullable(),
  status: receiptStatusSchema.default('ACCEPTED'), // Default status
  store_location: z.string().optional().nullable(),
  grn_remarks: z.string().optional().nullable(),
  received_date: z.string().refine((val) => !isNaN(Date.parse(val)), {
    message: 'Invalid date format',
  }),
  received_time: z.string().optional().nullable(),
  material_receipts: z
    .array(createGRNMaterialReceiptSchema)
    .min(1, 'At least one material receipt is required'),
});

// Transform form schema to match database schema
export const transformCreateGRNFormSchema = createGRNFormSchema.transform(
  (data) => {
    let receivedDate = new Date(data.received_date);

    if (data.received_time && data.received_time.trim() !== '') {
      const [hours, minutes] = data.received_time.split(':').map(Number);
      if (!isNaN(hours) && !isNaN(minutes)) {
        receivedDate.setHours(hours, minutes, 0, 0);
      }
    } else {
      receivedDate.setHours(0, 0, 0, 0);
    }

    const materialReceipts = data.material_receipts.map((receipt) => ({
      material_id: receipt.material_id,
      ordered: parseInt(receipt.ordered),
      chainage: receipt.chainage || null,
      quality: receipt.quality || null,
      accepted: parseInt(receipt.accepted),
      Rejected: parseInt(receipt.Rejected),
      received: parseInt(receipt.received),
    }));

    return {
      po_id: data.po_id,
      gate_entry_number: data.gate_entry_number || null,
      vehicle_number: data.vehicle_number || null,
      driver_name: data.driver_name || null,
      driver_contact: data.driver_contact || null,
      transport_mode: data.transport_mode || null,
      status: data.status,
      received_date: receivedDate,
      received_time: data.received_time || null,
      store_location: data.store_location || null,
      grn_remarks: data.grn_remarks || null,
      material_receipts: {
        create: materialReceipts,
      },
    };
  },
);

// Types
export type GRN = z.infer<typeof grnSchema>;
export type GRNMaterialReceipt = z.infer<typeof grnMaterialReceiptSchema>;
export type CreateGRN = z.infer<typeof createGRNSchema>;
export type CreateGRNForm = z.infer<typeof createGRNFormSchema>;
export type CreateGRNFormTransformed = z.infer<
  typeof transformCreateGRNFormSchema
>;
export type CreateGRNMaterialReceipt = z.infer<
  typeof createGRNMaterialReceiptSchema
>;
export type CreateGRNMaterialReceiptTransformed = z.infer<
  typeof createGRNMaterialReceiptFormSchema
>;
export type UpdateGRN = z.infer<typeof updateGRNSchema>;
export type UpdateGRNMaterialReceipt = z.infer<
  typeof updateGRNMaterialReceiptSchema
>;
export type UpdateGRNQualityCheck = z.infer<typeof updateGRNQualityCheckSchema>;
export type UpdateMaterialReceipt = z.infer<typeof updateMaterialReceiptSchema>;

// Validation for material receipt quantities
export const validateMaterialReceiptQuantities = (
  data: CreateGRNMaterialReceiptTransformed,
) => {
  const errors: string[] = [];

  // Check if accepted + rejected equals received
  if (data.accepted + data.Rejected !== data.received) {
    errors.push('Accepted + Rejected must equal Received quantity');
  }

  // Check if accepted + rejected doesn't exceed ordered
  if (data.accepted + data.Rejected > data.ordered) {
    errors.push('Accepted + Rejected cannot exceed Ordered quantity');
  }

  return errors;
};
