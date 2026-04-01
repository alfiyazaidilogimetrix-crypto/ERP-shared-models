import { z } from 'zod';

export const workScopeSchema = z.object({
    id: z.number().int().positive().optional(),
    project_id: z.number().int().positive(),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});

export const workScopeItemSchema = z.object({
    id: z.number().int().positive().optional(),
    workscope_id: z.number().int().positive(),
    material_id: z.number().int().positive().optional().nullable(),
    unit_id: z.number().int().positive(),
    activity_id: z.number().int().positive(),
    category_id: z.number().int().positive(),
    length: z.number().int().nullable().optional(),
    executed: z.number().nullable().optional(),
    quantity: z.number().nullable().optional(),
    balanced: z.number().nullable().optional(),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});

export type WorkScope = z.infer<typeof workScopeSchema>;
export type WorkScopeItem = z.infer<typeof workScopeItemSchema>;
