import { z } from 'zod';
import { transportModeSchema, receiptStatusSchema } from './enums';

// Base schemas without relationships
export const grnBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  po_id: z.number().int().positive(),
  gate_entry_number: z.string().max(50).nullable().optional(),
  vehicle_number: z.string().max(20).nullable().optional(),
  driver_name: z.string().max(100).nullable().optional(),
  driver_contact: z.string().max(20).nullable().optional(),
  transport_mode: transportModeSchema.nullable().optional(),
  status: receiptStatusSchema,
  received_date: z.date(),
  received_time: z.string().max(10).nullable().optional(), // String for HH:MM format
  store_location: z.string().max(200).nullable().optional(),
  quality_check_completed: z.boolean().default(false),
  grn_remarks: z.string().max(1000).nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const grnMaterialReceiptBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  grn_id: z.number().int().positive(),
  material_id: z.number().int().positive(),
  ordered: z.number().int().positive(),
  chainage: z.string().max(100).nullable().optional(),
  quality: z.string().max(50).nullable().optional(),
  accepted: z.number().int().min(0).default(0),
  rejected: z.number().int().min(0).default(0), // Changed to lowercase
  received: z.number().int().min(0).default(0),
  created_at: z.date().optional(),
});

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

// Create GRN Material Receipt schema - for form input (accepts strings)
export const createGRNMaterialReceiptInputSchema = z
  .object({
    material_id: z.number().int().positive(),
    ordered: z
      .string()
      .min(1, 'Ordered quantity is required')
      .refine(
        (val) =>
          !isNaN(parseFloat(val)) &&
          parseFloat(val) > 0 &&
          Number.isInteger(parseFloat(val)),
        {
          message: 'Ordered quantity must be a positive integer',
        },
      ),
    chainage: z.string().max(100).optional().nullable(),
    quality: z.string().max(50).optional().nullable(),
    accepted: z
      .string()
      .refine(
        (val) =>
          !isNaN(parseFloat(val)) &&
          parseFloat(val) >= 0 &&
          Number.isInteger(parseFloat(val)),
        {
          message: 'Accepted quantity must be a non-negative integer',
        },
      )
      .default('0'),
    rejected: z
      .string()
      .refine(
        (val) =>
          !isNaN(parseFloat(val)) &&
          parseFloat(val) >= 0 &&
          Number.isInteger(parseFloat(val)),
        {
          message: 'Rejected quantity must be a non-negative integer',
        },
      )
      .default('0'),
    received: z
      .string()
      .refine(
        (val) =>
          !isNaN(parseFloat(val)) &&
          parseFloat(val) >= 0 &&
          Number.isInteger(parseFloat(val)),
        {
          message: 'Received quantity must be a non-negative integer',
        },
      )
      .default('0'),
  })
  .superRefine((data, ctx) => {
    const ordered = parseInt(data.ordered);
    const accepted = parseInt(data.accepted);
    const rejected = parseInt(data.rejected);
    const received = parseInt(data.received);

    // Validate received = accepted + rejected
    if (accepted + rejected !== received) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Accepted + Rejected must equal Received quantity',
        path: ['received'],
      });
    }

    // Validate received doesn't exceed ordered
    if (received > ordered) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Received quantity cannot exceed Ordered quantity',
        path: ['received'],
      });
    }
  });

// Transform string input schema to number output schema
export const createGRNMaterialReceiptSchema =
  createGRNMaterialReceiptInputSchema.transform((data) => ({
    material_id: data.material_id,
    ordered: parseInt(data.ordered),
    chainage: data.chainage,
    quality: data.quality,
    accepted: parseInt(data.accepted),
    rejected: parseInt(data.rejected),
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
  grn_remarks: z.string().max(1000).optional().nullable(),
});

// Material receipt update schema
export const updateMaterialReceiptInputSchema = z.object({
  id: z.number().int().positive(),
  accepted: z
    .string()
    .refine(
      (val) =>
        !isNaN(parseFloat(val)) &&
        parseFloat(val) >= 0 &&
        Number.isInteger(parseFloat(val)),
      {
        message: 'Accepted quantity must be a non-negative integer',
      },
    )
    .optional(),
  rejected: z
    .string()
    .refine(
      (val) =>
        !isNaN(parseFloat(val)) &&
        parseFloat(val) >= 0 &&
        Number.isInteger(parseFloat(val)),
      {
        message: 'Rejected quantity must be a non-negative integer',
      },
    )
    .optional(),
  received: z
    .string()
    .refine(
      (val) =>
        !isNaN(parseFloat(val)) &&
        parseFloat(val) >= 0 &&
        Number.isInteger(parseFloat(val)),
      {
        message: 'Received quantity must be a non-negative integer',
      },
    )
    .optional(),
  quality: z.string().max(50).optional().nullable(),
  chainage: z.string().max(100).optional().nullable(),
});

export const updateMaterialReceiptSchema =
  updateMaterialReceiptInputSchema.transform((data) => ({
    id: data.id,
    accepted: data.accepted ? parseInt(data.accepted) : undefined,
    rejected: data.rejected ? parseInt(data.rejected) : undefined,
    received: data.received ? parseInt(data.received) : undefined,
    quality: data.quality,
    chainage: data.chainage,
  }));

// Combined date/time schema for forms
export const grnDateTimeBaseSchema = z.object({
  received_date: z.string().refine((val) => !isNaN(Date.parse(val)), {
    message: 'Invalid date format',
  }),
  received_time: z
    .string()
    .optional()
    .nullable()
    .refine(
      (val) => {
        if (!val || val.trim() === '') return true;
        return /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/.test(val); // HH:MM format
      },
      {
        message: 'Time must be in HH:MM format or empty',
      },
    ),
});

export const grnDateTimeSchema = grnDateTimeBaseSchema.transform((data) => {
  let receivedDate = new Date(data.received_date);

  if (data.received_time && data.received_time.trim() !== '') {
    receivedDate.setHours(0, 0, 0, 0); // Reset time for date only
  } else {
    receivedDate.setHours(0, 0, 0, 0);
  }

  return {
    received_date: receivedDate,
    received_time: data.received_time?.trim() || null, // Return null if empty (string, not Date)
  };
});

// Create GRN form input schema (frontend submission)
export const createGRNFormInputSchema = z
  .object({
    po_id: z.number().int().positive(),
    gate_entry_number: z.string().max(50).optional().nullable(),
    vehicle_number: z.string().max(20).optional().nullable(),
    driver_name: z.string().max(100).optional().nullable(),
    driver_contact: z
      .string()
      .max(20)
      .optional()
      .nullable()
      .refine((val) => !val || /^[\d\s\-\+\(\)]+$/.test(val), {
        message: 'Invalid contact number format',
      }),
    transport_mode: transportModeSchema.optional().nullable(),
    status: receiptStatusSchema,
    store_location: z.string().max(200).optional().nullable(),
    grn_remarks: z.string().max(1000).optional().nullable(),
    quality_check_completed: z.boolean().optional().default(false),
    received_date: z.string().refine((val) => !isNaN(Date.parse(val)), {
      message: 'Invalid date format',
    }),
    received_time: z
      .string()
      .optional()
      .nullable()
      .refine(
        (val) => {
          if (!val || val.trim() === '') return true;
          return /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/.test(val);
        },
        {
          message: 'Time must be in HH:MM format or empty',
        },
      ),
    material_receipts: z
      .array(createGRNMaterialReceiptInputSchema)
      .min(1, 'At least one material receipt is required'),
  })
  .superRefine((data, ctx) => {
    // Validate that if transport mode is not SELF_PICKUP, vehicle and driver are required
    if (data.transport_mode && data.transport_mode !== 'SELF_PICKUP') {
      if (!data.vehicle_number) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Vehicle number is required for non-self-pickup transport',
          path: ['vehicle_number'],
        });
      }
      if (!data.driver_name) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Driver name is required for non-self-pickup transport',
          path: ['driver_name'],
        });
      }
    }

    // Validate quality check can only be true for ACCEPTED or PARTIALLY_ACCEPTED status
    if (data.quality_check_completed === true) {
      const validStatuses = ['ACCEPTED', 'PARTIALLY_ACCEPTED'];
      if (!validStatuses.includes(data.status)) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message:
            'Quality check can only be completed for ACCEPTED or PARTIALLY_ACCEPTED GRNs',
          path: ['quality_check_completed'],
        });
      }
    }

    // Calculate suggested status based on material quantities
    const totalOrdered = data.material_receipts.reduce(
      (sum, item) => sum + parseInt(item.ordered),
      0,
    );
    const totalAccepted = data.material_receipts.reduce(
      (sum, item) => sum + parseInt(item.accepted),
      0,
    );
    const totalRejected = data.material_receipts.reduce(
      (sum, item) => sum + parseInt(item.rejected),
      0,
    );

    let suggestedStatus = data.status;
    if (totalAccepted === totalOrdered && totalRejected === 0) {
      suggestedStatus = 'ACCEPTED';
    } else if (totalRejected === totalOrdered && totalAccepted === 0) {
      suggestedStatus = 'REJECTED';
    } else if (totalAccepted > 0 || totalRejected > 0) {
      suggestedStatus = 'RECEIVED';
    }

    // Warn if status doesn't match calculated status
    if (data.status !== suggestedStatus) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: `Based on material quantities, status should be "${suggestedStatus}"`,
        path: ['status'],
        fatal: false, // Make this a warning, not an error
      });
    }
  });

// Transform form schema to match database schema
export const createGRNFormSchema = createGRNFormInputSchema.transform(
  (data) => {
    let receivedDate = new Date(data.received_date);
    receivedDate.setHours(0, 0, 0, 0); // Reset time portion

    const materialReceipts = data.material_receipts.map((receipt) => ({
      material_id: receipt.material_id,
      ordered: parseInt(receipt.ordered),
      chainage: receipt.chainage || null,
      quality: receipt.quality || null,
      accepted: parseInt(receipt.accepted),
      rejected: parseInt(receipt.rejected),
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
      received_time: data.received_time?.trim() || null,
      store_location: data.store_location || null,
      quality_check_completed: data.quality_check_completed,
      grn_remarks: data.grn_remarks || null,
      material_receipts: {
        create: materialReceipts,
      },
    };
  },
);

// Bulk update material receipts schema
export const updateMaterialReceiptsBulkInputSchema = z
  .object({
    material_receipts: z
      .array(
        z.object({
          id: z.number().int().positive('Material receipt ID is required'),
          accepted: z
            .string()
            .refine(
              (val) =>
                !isNaN(parseFloat(val)) &&
                parseFloat(val) >= 0 &&
                Number.isInteger(parseFloat(val)),
              {
                message: 'Accepted quantity must be a non-negative integer',
              },
            ),
          rejected: z
            .string()
            .refine(
              (val) =>
                !isNaN(parseFloat(val)) &&
                parseFloat(val) >= 0 &&
                Number.isInteger(parseFloat(val)),
              {
                message: 'Rejected quantity must be a non-negative integer',
              },
            ),
          received: z
            .string()
            .refine(
              (val) =>
                !isNaN(parseFloat(val)) &&
                parseFloat(val) >= 0 &&
                Number.isInteger(parseFloat(val)),
              {
                message: 'Received quantity must be a non-negative integer',
              },
            ),
          quality: z.string().max(50).optional().nullable(),
          chainage: z.string().max(100).optional().nullable(),
        }),
      )
      .min(1, 'At least one material receipt is required'),
  })
  .superRefine((data, ctx) => {
    data.material_receipts.forEach((receipt, index) => {
      const accepted = parseInt(receipt.accepted);
      const rejected = parseInt(receipt.rejected);
      const received = parseInt(receipt.received);

      if (accepted + rejected !== received) {
        ctx.addIssue({
          code: z.ZodIssueCode.custom,
          message: 'Accepted + Rejected must equal Received quantity',
          path: ['material_receipts', index],
        });
      }
    });
  });

export const updateMaterialReceiptsBulkSchema =
  updateMaterialReceiptsBulkInputSchema.transform((data) => ({
    material_receipts: data.material_receipts.map((receipt) => ({
      id: receipt.id,
      accepted: parseInt(receipt.accepted),
      rejected: parseInt(receipt.rejected),
      received: parseInt(receipt.received),
      quality: receipt.quality,
      chainage: receipt.chainage,
    })),
  }));

// Types
export type GRN = z.infer<typeof grnSchema>;
export type GRNMaterialReceipt = z.infer<typeof grnMaterialReceiptSchema>;
export type CreateGRN = z.infer<typeof createGRNSchema>;
export type CreateGRNFormInput = z.infer<typeof createGRNFormInputSchema>;
export type CreateGRNForm = z.infer<typeof createGRNFormSchema>;
export type CreateGRNMaterialReceiptInput = z.infer<
  typeof createGRNMaterialReceiptInputSchema
>;
export type CreateGRNMaterialReceipt = z.infer<
  typeof createGRNMaterialReceiptSchema
>;
export type UpdateGRN = z.infer<typeof updateGRNSchema>;
export type UpdateGRNMaterialReceipt = z.infer<
  typeof updateGRNMaterialReceiptSchema
>;
export type UpdateGRNQualityCheck = z.infer<typeof updateGRNQualityCheckSchema>;
export type UpdateMaterialReceiptInput = z.infer<
  typeof updateMaterialReceiptInputSchema
>;
export type UpdateMaterialReceipt = z.infer<typeof updateMaterialReceiptSchema>;
export type UpdateMaterialReceiptsBulkInput = z.infer<
  typeof updateMaterialReceiptsBulkInputSchema
>;
export type UpdateMaterialReceiptsBulk = z.infer<
  typeof updateMaterialReceiptsBulkSchema
>;

// Helper function for material receipt validation
export const validateMaterialReceiptQuantities = (
  data: CreateGRNMaterialReceipt,
) => {
  const errors: string[] = [];

  // Check if accepted + rejected equals received
  if (data.accepted + data.rejected !== data.received) {
    errors.push('Accepted + Rejected must equal Received quantity');
  }

  // Check if accepted + rejected doesn't exceed ordered
  if (data.accepted + data.rejected > data.ordered) {
    errors.push('Accepted + Rejected cannot exceed Ordered quantity');
  }

  return errors;
};

// Helper to validate time format
export const isValidTimeFormat = (time: string): boolean => {
  if (!time || time.trim() === '') return true;
  return /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/.test(time);
};
