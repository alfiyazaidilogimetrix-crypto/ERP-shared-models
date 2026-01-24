import { z } from 'zod';

// ContractorProject Schema
export const contractorProjectSchema = z.object({
  id: z.number().int().positive().optional(),
  contractorId: z.number().int().positive(),
  projectId: z.number().int().positive(),
  partnership_percentage: z.string().nullable().optional(),
  start_date: z.date().nullable().optional(),
  end_date: z.date().nullable().optional(),
  overall_budget: z.string().nullable().optional(),
});

export type ContractorProject = z.infer<typeof contractorProjectSchema>;

// ContractorFiles Schema
export const contractorFilesSchema = z.object({
  id: z.number().int().positive().optional(),
  contactProjectId: z.number().int().positive(),
  file_id: z.number().int().positive(),
  report_type: z.string().min(1),
  description: z.string().nullable().optional(),
});

export type ContractorFiles = z.infer<typeof contractorFilesSchema>;
