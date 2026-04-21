import { z } from 'zod';

// WorkScopeStatus enum
export const WorkScopeStatusEnum = z.enum([
    'PENDING',
    'CONFIGURED',
    'IN_PROGRESS',
    'COMPLETED',
    'ON_HOLD'
]);

// WorkScope schema
export const workScopeSchema = z.object({
    id: z.number().int().positive().optional(),
    project_id: z.number().int().positive(),
    company_id: z.number().int().positive(),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});

// WorkScopeItem schema
export const workScopeItemSchema = z.object({
    id: z.number().int().positive().optional(),
    workscope_id: z.number().int().positive(),
    activity_id: z.number().int().positive(),
    quantity: z.number().nullable().optional(),
    executed_quantity: z.number().nullable().optional(),
    balanced_quantity: z.number().nullable().optional(),
    status: WorkScopeStatusEnum.default('PENDING'),
    start_date: z.date().optional().nullable(),
    end_date: z.date().optional().nullable(),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});

// WorkscopeMaterial schema
export const workscopeMaterialSchema = z.object({
    id: z.number().int().positive().optional(),
    workscope_item_id: z.number().int().positive(),
    material_id: z.number().int().positive(),
    quantity: z.number().nullable().optional(),
    unit_id: z.number().int().positive(),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});

// LabourAllocation schema
export const labourAllocationSchema = z.object({
    id: z.number().int().positive().optional(),
    workscope_item_id: z.number().int().positive(),
    labour_type: z.string().nullable().optional(),
    count: z.number().int().nullable().optional(),
    days: z.number().int().nullable().optional(),
    rate_per_day: z.number().nullable().optional(),
    total_cost: z.number().nullable().optional(),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});

// MachineryAllocation schema
export const machineryAllocationSchema = z.object({
    id: z.number().int().positive().optional(),
    workscope_item_id: z.number().int().positive(),
    machine_id: z.number().int().positive(),
    count: z.number().int().nullable().optional(),
    hours: z.number().nullable().optional(),
    rate_per_hour: z.number().nullable().optional(),
    total_cost: z.number().nullable().optional(),
    createdAt: z.date().optional(),
    updatedAt: z.date().optional(),
});

// Types
export type WorkScope = z.infer<typeof workScopeSchema>;
export type WorkScopeItem = z.infer<typeof workScopeItemSchema>;
export type WorkscopeMaterial = z.infer<typeof workscopeMaterialSchema>;
export type LabourAllocation = z.infer<typeof labourAllocationSchema>;
export type MachineryAllocation = z.infer<typeof machineryAllocationSchema>;
export type WorkScopeStatus = z.infer<typeof WorkScopeStatusEnum>;