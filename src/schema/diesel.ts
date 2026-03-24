import { z } from 'zod';
import { dieselTransactionTypeSchema } from './enums';

export const dieselTransactionSchema = z.object({
  id: z.number().int().positive().optional(),
  transaction_type: dieselTransactionTypeSchema,
  date: z.date().or(z.string().pipe(z.coerce.date())),
  project_id: z.number().int().positive(),
  // Diesel Receipt Fields
  vendor_id: z.number().int().positive().nullable().optional(),
  invoice_number: z.string().nullable().optional(),
  quantity: z.string().nullable().optional(),
  rate_per_litre: z.string().nullable().optional(),
  total_amount: z.string().nullable().optional(),
  // Diesel Issue Fields
  equipment_name: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  purpose: z.string().nullable().optional(),
  issue_rate_per_litre: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type DieselTransaction = z.infer<typeof dieselTransactionSchema>;

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

export const dieselInwardSchema = z.object({
  id: z.number().int().positive().optional(),
  supplier_id: z.number().int().positive(),
  state: z.string().min(1, 'State is required'),
  district: z.string().min(1, 'District is required'),
  pincode: z.string().min(1, 'Pincode is required'),
  quantity_litres: z.number().nonnegative(),
  rate_per_litre: z.number().nonnegative(),
  total_amount: z.number().nonnegative(),
  delivery_person_name: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  assigned_to: z.number().int().positive(),
  received_by: z.string().min(1, 'Received by is required'),
  received_at: z.date().or(z.string().pipe(z.coerce.date())),
  invoiceNumber: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const dieselStockSchema = z.object({
  id: z.number().int().positive().optional(),
  state: z.string().min(1, 'State is required'),
  district: z.string().min(1, 'District is required'),
  pincode: z.string().min(1, 'Pincode is required'),
  current_quantity_litres: z.number().nonnegative(),
  tank_capacity_litres: z.number().nonnegative().nullable().optional(),
  manager_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type DieselConsumption = z.infer<typeof dieselConsumptionSchema>;
export type DieselConsumptionCreate = z.infer<typeof dieselConsumptionCreateSchema>;
export type DieselSupplier = z.infer<typeof dieselSupplierSchema>;
export type DieselInward = z.infer<typeof dieselInwardSchema>;
export type DieselStock = z.infer<typeof dieselStockSchema>;
