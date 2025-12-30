import { z } from 'zod';
import { prStatusSchema, urgencyLevelSchema } from './enums';

// Base schemas without relationships
export const prBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  pr_code: z.string().min(1, 'PR code is required'),
  urgency_level: urgencyLevelSchema,
  status: prStatusSchema.default('DRAFT'),
  remarks: z.string().nullable().optional(),
  user_id: z.number().int().positive().optional().nullable(), // Changed from string to number
  approved_by: z.number().int().positive().optional().nullable(), // Changed from string to number
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const prMaterialItemBaseSchema = z.object({
  id: z.number().int().positive().optional(),
  pr_id: z.number().int().positive(),
  material_id: z.number().int().positive(),
  quantity: z
    .string()
    .min(1, 'Quantity is required')
    .refine((val) => !isNaN(parseFloat(val)) && parseFloat(val) > 0, {
      message: 'Quantity must be a positive number',
    }),
  required_date: z.date(),
  created_at: z.date().optional(),
});

// User schemas (for relationships)
export const userBaseSchema = z.object({
  id: z.number().int().positive(),
  name: z.string(),
  email: z.string().email().optional(),
  role: z.string().optional(),
});

// Full schemas with relationships
export const prSchema = prBaseSchema.extend({
  material_items: z.array(prMaterialItemBaseSchema).optional(),
  project: z
    .object({
      id: z.number().int().positive(),
      name: z.string(),
      code: z.string(),
      location: z.string().optional(),
    })
    .optional(),
  user: userBaseSchema.optional().nullable(),
  approvedUser: userBaseSchema.optional().nullable(),
  pos: z
    .array(
      z.object({
        id: z.number().int().positive(),
        po_code: z.string(),
        po_status: z.string(),
        total_amount: z.string(),
      }),
    )
    .optional(),
});

export const prMaterialItemSchema = prMaterialItemBaseSchema.extend({
  pr: prBaseSchema.optional(),
  material: z
    .object({
      id: z.number().int().positive(),
      name: z.string(),
      code: z.string(),
      unit: z.string(),
      category: z.string().optional(),
    })
    .optional(),
});

// Create schemas (for form submissions)
export const createPRSchema = prBaseSchema
  .omit({
    id: true,
    status: true,
    approved_by: true,
    created_at: true,
    updated_at: true,
  })
  .extend({
    user_id: z.number().int().positive(), // Required for creation
    material_items: z
      .array(
        prMaterialItemBaseSchema.omit({
          id: true,
          pr_id: true,
          created_at: true,
        }),
      )
      .min(1, 'At least one material item is required'),
  })
  .refine(
    (data) => {
      // Validate that required dates are in the future
      const today = new Date();
      today.setHours(0, 0, 0, 0);

      return data.material_items.every((item) => {
        const requiredDate = new Date(item.required_date);
        requiredDate.setHours(0, 0, 0, 0);
        return requiredDate >= today;
      });
    },
    {
      message: 'All required dates must be today or in the future',
      path: ['material_items'],
    },
  );

export const createPRMaterialItemSchema = prMaterialItemBaseSchema.omit({
  id: true,
  pr_id: true,
  created_at: true,
});

// Update schemas
export const updatePRSchema = prBaseSchema
  .partial()
  .extend({
    id: z.number().int().positive(),
  })
  .superRefine((data, ctx) => {
    // Validate status transitions
    if (data.status === 'APPROVED' && !data.approved_by) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Approved by field is required when status is APPROVED',
        path: ['approved_by'],
      });
    }

    // Validate that we can't set approved_by for DRAFT status
    if (data.status === 'DRAFT' && data.approved_by) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'Cannot set approved_by for DRAFT status',
        path: ['approved_by'],
      });
    }

    // Validate that we can't remove user_id
    if (data.user_id === null) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: 'user_id cannot be removed',
        path: ['user_id'],
      });
    }
  });

export const updatePRMaterialItemSchema = prMaterialItemBaseSchema
  .partial()
  .extend({
    id: z.number().int().positive(),
  })
  .refine(
    (data) => {
      // Validate required date if provided
      if (data.required_date) {
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        const requiredDate = new Date(data.required_date);
        requiredDate.setHours(0, 0, 0, 0);
        return requiredDate >= today;
      }
      return true;
    },
    {
      message: 'Required date must be today or in the future',
      path: ['required_date'],
    },
  );

// Status change schemas
export const submitPRSchema = z.object({
  status: z.literal('SUBMITTED'),
  remarks: z.string().max(1000).optional().nullable(),
});

export const approvePRSchema = z.object({
  status: z.literal('APPROVED'),
  approved_by: z.number().int().positive('Approver ID is required'),
  remarks: z.string().max(1000).optional().nullable(),
});

export const rejectPRSchema = z.object({
  status: z.literal('REJECTED'),
  remarks: z.string().min(1, 'Rejection remarks are required').max(1000),
});

export const closePRSchema = z.object({
  status: z.literal('CLOSED'),
  remarks: z.string().max(1000).optional().nullable(),
});

// Response schemas
export const prResponseSchema = prSchema.extend({
  material_items: z.array(prMaterialItemSchema).optional(),
  project: z
    .object({
      id: z.number().int().positive(),
      name: z.string(),
      code: z.string(),
      location: z.string().optional(),
      manager: z.string().optional(),
    })
    .optional(),
  user: userBaseSchema.optional().nullable(),
  approvedUser: userBaseSchema.optional().nullable(),
  pos: z
    .array(
      z.object({
        id: z.number().int().positive(),
        po_code: z.string(),
        po_date: z.string().datetime(),
        po_status: z.string(),
        total_amount: z.string(),
        vendor: z
          .object({
            id: z.number().int().positive(),
            name: z.string(),
          })
          .optional(),
      }),
    )
    .optional(),
});

export const prSummaryResponseSchema = prBaseSchema.extend({
  project: z
    .object({
      id: z.number().int().positive(),
      name: z.string(),
      code: z.string(),
    })
    .optional(),
  material_items_count: z.number().int().nonnegative(),
  total_quantity: z.string().optional(),
  pos_count: z.number().int().nonnegative(),
  user: z
    .object({
      id: z.number().int().positive(),
      name: z.string(),
    })
    .optional(),
  approvedUser: z
    .object({
      id: z.number().int().positive(),
      name: z.string(),
    })
    .optional()
    .nullable(),
});

// Date string schemas for API input/output (since APIs typically use strings)
export const prBaseStringSchema = prBaseSchema.extend({
  created_at: z.string().datetime().optional(),
  updated_at: z.string().datetime().optional(),
});

export const prMaterialItemStringSchema = prMaterialItemBaseSchema.extend({
  required_date: z.string().datetime(),
  created_at: z.string().datetime().optional(),
});

// API create/update schemas with string dates
export const createPRStringSchema = createPRSchema.pipe(
  z
    .object({
      material_items: z.array(
        createPRMaterialItemSchema.extend({
          required_date: z
            .string()
            .datetime('Required date must be a valid ISO date'),
        }),
      ),
    })
    .partial(),
);

export const updatePRStringSchema = updatePRSchema.pipe(
  z
    .object({
      material_items: z
        .array(
          updatePRMaterialItemSchema.pipe(
            z
              .object({
                required_date: z.string().datetime().optional(),
              })
              .partial(),
          ),
        )
        .optional(),
    })
    .partial(),
);

// Types
export type PR = z.infer<typeof prSchema>;
export type PRMaterialItem = z.infer<typeof prMaterialItemSchema>;
export type CreatePR = z.infer<typeof createPRSchema>;
export type CreatePRString = z.infer<typeof createPRStringSchema>;
export type CreatePRMaterialItem = z.infer<typeof createPRMaterialItemSchema>;
export type UpdatePR = z.infer<typeof updatePRSchema>;
export type UpdatePRString = z.infer<typeof updatePRStringSchema>;
export type UpdatePRMaterialItem = z.infer<typeof updatePRMaterialItemSchema>;
export type SubmitPR = z.infer<typeof submitPRSchema>;
export type ApprovePR = z.infer<typeof approvePRSchema>;
export type RejectPR = z.infer<typeof rejectPRSchema>;
export type ClosePR = z.infer<typeof closePRSchema>;
export type PRResponse = z.infer<typeof prResponseSchema>;
export type PRSummaryResponse = z.infer<typeof prSummaryResponseSchema>;
export type UserBase = z.infer<typeof userBaseSchema>;
