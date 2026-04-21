import { z } from "zod";

export const warehouseSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1, "Name is required"),
  address: z.string().min(1, "Address is required"),
  state: z.string().min(1, "State is required"),
  pincode: z.string().min(1, "Pincode is required"),
  district: z.string().min(1, "District is required"),
  company_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Warehouse = z.infer<typeof warehouseSchema>;
