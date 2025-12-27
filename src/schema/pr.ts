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
  user_id: z.string().min(1, 'User ID is required'),
  approved_by: z.string().nullable().optional(),
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

// Full schemas with relationships
export const prSchema = prBaseSchema.extend({
  material_items: z.array(prMaterialItemBaseSchema).optional(),
  project: z.any().optional(), // Project type can be defined separately
});

export const prMaterialItemSchema = prMaterialItemBaseSchema.extend({
  pr: prBaseSchema.optional(),
  material: z.any().optional(), // Material type can be defined separately
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
    material_items: z
      .array(
        prMaterialItemBaseSchema.omit({
          id: true,
          pr_id: true,
          created_at: true,
        }),
      )
      .min(1, 'At least one material item is required'),
  });

export const createPRMaterialItemSchema = prMaterialItemBaseSchema.omit({
  id: true,
  pr_id: true,
  created_at: true,
});

// Update schemas
export const updatePRSchema = prBaseSchema.partial().extend({
  id: z.number().int().positive(),
});

export const updatePRMaterialItemSchema = prMaterialItemBaseSchema
  .partial()
  .extend({
    id: z.number().int().positive(),
  });

// Types
export type PR = z.infer<typeof prSchema>;
export type PRMaterialItem = z.infer<typeof prMaterialItemSchema>;
export type CreatePR = z.infer<typeof createPRSchema>;
export type CreatePRMaterialItem = z.infer<typeof createPRMaterialItemSchema>;
export type UpdatePR = z.infer<typeof updatePRSchema>;
export type UpdatePRMaterialItem = z.infer<typeof updatePRMaterialItemSchema>;
