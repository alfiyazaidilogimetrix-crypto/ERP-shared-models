import { z } from "zod";

export const subContractorSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1),
  scope_of_work: z.string().nullable().optional(),
  contract_value: z.string().nullable().optional(),
  chainage_start_km: z.string().nullable().optional(),
  chainage_end_km: z.string().nullable().optional(),
  contract_start_date: z.date().nullable().optional(),
  contract_end_date: z.date().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const contractorVendorSchema = z.object({
  id: z.number().int().positive().optional(),
  contractorId: z.number().int(),
  vendorId: z.number().int(),
});

export const contractorProjectSchema = z.object({
  id: z.number().int().positive().optional(),
  contractorId: z.number().int(),
  projectId: z.number().int(),
});

export type SubContractor = z.infer<typeof subContractorSchema>;
export type ContractorVendor = z.infer<typeof contractorVendorSchema>;
export type ContractorProject = z.infer<typeof contractorProjectSchema>;
