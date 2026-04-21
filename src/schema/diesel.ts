import { z } from 'zod';


export const dieselConsumptionSchema = z.object({
  id: z.number().int().positive().optional(),
  machine_id: z.number().int().positive(),
  activity_id: z.number().int().positive(),
  diesel_used_liters: z.number().int().nonnegative(),
  hours_used: z.number().int().nonnegative(),
  operator_name: z.string().min(1, 'Operator name is required'),
  date: z.date().or(z.string().pipe(z.coerce.date())),
  issued_by: z.number().int().positive(),
  remarks: z.string().optional(),
  project_id: z.number().int().positive(),
  company_id: z.number().int().positive(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export const dieselConsumptionCreateSchema = dieselConsumptionSchema.omit({
  id: true,
  created_at: true,
  updated_at: true,
});

export const dieselSupplierSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(1, 'Name is required'),
  contact_number: z.string().min(1, 'Contact number is required'),
  address: z.string().min(1, 'Address is required'),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const dieselInwardFileSchema = z.object({
  id: z.number().int().positive().optional(),
  diesel_inward_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export const dieselInwardSchema = z.object({
  id: z.number().int().positive().optional(),
  supplier_id: z.number().int().positive(),
  store_location_id: z.number().int().positive().nullable().optional(),
  quantity_litres: z.number().nonnegative(),
  rate_per_litre: z.number().nonnegative(),
  total_amount: z.number().nonnegative(),
  delivery_person_name: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  received_by: z.number().int().positive().nullable().optional(),
  received_at: z.date().nullable().optional(),
  status: z.enum(['PENDING', 'RECEIVED', 'CANCELLED']).optional(),
  invoiceNumber: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  company_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
  dieselInwardFiles: z.array(dieselInwardFileSchema).optional(),
});

export const dieselStockSchema = z.object({
  id: z.number().int().positive().optional(),
  warehouse_id: z.number().int().positive(),
  current_quantity_litres: z.number().nonnegative(),
  tank_capacity_litres: z.number().nonnegative().nullable().optional(),
  manager_id: z.number().int().positive(),
  company_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type DieselConsumption = z.infer<typeof dieselConsumptionSchema>;
export type DieselConsumptionCreate = z.infer<typeof dieselConsumptionCreateSchema>;
export type DieselSupplier = z.infer<typeof dieselSupplierSchema>;
export type DieselInward = z.infer<typeof dieselInwardSchema>;
export type DieselInwardFile = z.infer<typeof dieselInwardFileSchema>;
export type DieselStock = z.infer<typeof dieselStockSchema>;
