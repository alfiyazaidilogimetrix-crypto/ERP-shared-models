import { z } from 'zod';

export const providerSchema = z.enum(['credentials', 'google']);

export const receiptStatusSchema = z.enum(['RECEIVED', 'ACCEPTED', 'REJECTED']);

export const poStatusSchema = z.enum([
  'DRAFT',
  'ISSUED',
  'PARTIALLY_DELIVERED',
  'DELIVERED',
  'CANCELLED',
  'CLOSED',
]);

export const transportModeSchema = z.enum([
  'ROAD',
  'RAIL',
  'SEA',
  'AIR',
  'SELF_PICKUP',
]);

export const urgencyLevelSchema = z.enum(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']);

export const projectTypeSchema = z.enum(['HAM', 'EPC', 'BOT', 'OTHER']);

export const projectStatusSchema = z.enum([
  'PLANNED',
  'IN_PROGRESS',
  'ON_HOLD',
  'COMPLETED',
  'CANCELLED',
]);

export const dieselTransactionTypeSchema = z.enum([
  'DIESEL_RECEIPT',
  'DIESEL_ISSUE',
]);

export const labourStatusSchema = z.enum([
  'ACTIVE',
  'INACTIVE',
  'LEFT',
  'BLACKLISTED',
]);

export const labourTypeSchema = z.enum(['DIRECT', 'CONTRACT']);

// In enums.ts
export const attendanceStatusSchema = z.enum([
  'PRESENT',
  'ABSENT',
  'HALF_DAY',
  'ON_LEAVE',
]);
export const prStatusSchema = z.enum([
  'DRAFT',
  'SUBMITTED',
  'INVENTORY_CHECK',
  'PARTIAL_AVAILABLE',
  'PROCUREMENT_REQUIRED',
  'APPROVED',
  'REJECTED',
  'CLOSED',
]);

export const prTypeSchema = z.enum(['INVENTORY', 'PROCUREMENT', 'NONE']);

export const stockStatusSchema = z.enum([
  'in_stock',
  'low_stock',
  'out_of_stock',
  'reserved',
  'damaged',
  'disposed',
]);

// Enum schemas
export const vendorStatusSchema = z.enum(['ACTIVE', 'INACTIVE', 'SUSPENDED']);
export const vendorTypeSchema = z.enum(['WORK_VENDOR', 'MATERIAL_SUPPLIER']);

// Enum schemas
export const supplyStatusSchema = z.enum([
  'PENDING', // PO created, supply not started
  'APPROVED', // Approved for dispatch
  'IN_TRANSIT', // Vendor dispatched material
  'PARTIALLY_RECEIVED',
  'RECEIVED', // Fully received
  'REJECTED',
]);

export const supplyTypeSchema = z.enum(['TO_INVENTORY', 'DIRECT_TO_SITE']);
export type PRStatus = z.infer<typeof prStatusSchema>;
export type UrgencyLevel = z.infer<typeof urgencyLevelSchema>;
export type PRType = z.infer<typeof prTypeSchema>;
export type AttendanceStatus = z.infer<typeof attendanceStatusSchema>;
