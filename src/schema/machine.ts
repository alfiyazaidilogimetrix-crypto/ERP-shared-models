import { z } from 'zod';

export const machineSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1, 'Name is required'),
  type: z.string().min(1, 'Type is required'),
  is_owned: z.boolean().default(false),
  rent_per_hour: z.string().nullable().optional(),
  purchase_cost: z.string().nullable().optional(),
  project_id: z.number().int().positive(),
  machine_count: z.number().int().positive().default(1),
  company_id: z.number().int().positive(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const machineCreateSchema = machineSchema.omit({
  id: true,
  created_at: true,
  updated_at: true,
});

export const machineUpdateSchema = machineSchema
  .omit({
    id: true,
    created_at: true,
    updated_at: true,
  })
  .partial();

export type Machine = z.infer<typeof machineSchema>;
export type MachineCreate = z.infer<typeof machineCreateSchema>;
export type MachineUpdate = z.infer<typeof machineUpdateSchema>;
