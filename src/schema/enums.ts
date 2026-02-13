import { z } from 'zod';

export const providerSchema = z.enum(['credentials', 'google']);

export const receiptStatusSchema = z.enum([
  'RECEIVED',
  'ACCEPTED',
  'REJECTED',
  'PARTIALLY_ACCEPTED',
  'PENDING',
]);

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
  'IN_STOCK',
  'LOW_STOCK',
  'OUT_OF_STOCK',
  'RESERVED',
  'DAMAGED',
  'DISPOSED',
]);

// Vendor enums
export const vendorStatusSchema = z.enum(['ACTIVE', 'INACTIVE', 'SUSPENDED']);
export const vendorTypeSchema = z.enum(['SUB_CONTRACTOR', 'MATERIAL_SUPPLIER']);

// Supply enums
export const supplyStatusSchema = z.enum([
  'PENDING',
  'APPROVED',
  'IN_TRANSIT',
  'PARTIALLY_RECEIVED',
  'RECEIVED',
  'REJECTED',
]);

export const supplyTypeSchema = z.enum(['TO_INVENTORY', 'DIRECT_TO_SITE']);

// DPR Site type enum
export const siteTypeSchema = z.enum(['LHS', 'RHS', 'BHS']);

// Type exports
export type PRStatus = z.infer<typeof prStatusSchema>;
export type UrgencyLevel = z.infer<typeof urgencyLevelSchema>;
export type PRType = z.infer<typeof prTypeSchema>;
export type AttendanceStatus = z.infer<typeof attendanceStatusSchema>;
export type ReceiptStatus = z.infer<typeof receiptStatusSchema>;
export type TransportMode = z.infer<typeof transportModeSchema>;
export type POStatus = z.infer<typeof poStatusSchema>;
export type StockStatus = z.infer<typeof stockStatusSchema>;
export type VendorStatus = z.infer<typeof vendorStatusSchema>;
export type VendorType = z.infer<typeof vendorTypeSchema>;
export type SupplyStatus = z.infer<typeof supplyStatusSchema>;
export type SupplyType = z.infer<typeof supplyTypeSchema>;
export type SiteType = z.infer<typeof siteTypeSchema>;
export type DieselTransactionType = z.infer<typeof dieselTransactionTypeSchema>;
export type LabourStatus = z.infer<typeof labourStatusSchema>;
export type LabourType = z.infer<typeof labourTypeSchema>;
export type ProjectType = z.infer<typeof projectTypeSchema>;
export type ProjectStatus = z.infer<typeof projectStatusSchema>;
export type Provider = z.infer<typeof providerSchema>;
