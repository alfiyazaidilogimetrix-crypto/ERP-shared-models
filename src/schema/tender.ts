import { z } from 'zod';

export const tenderSchema = z.object({
    id: z.number().int().positive().optional(),
    file_id: z.number().int().positive(),
    project_id: z.number().int().positive().nullable().optional(),
    created_at: z.date().optional(),
    updated_at: z.date().optional(),
    file: z.any().optional(),
    project: z.any().optional(),
});



export type Tender = z.infer<typeof tenderSchema>;

