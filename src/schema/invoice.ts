import { z } from 'zod';

// Invoice Item Schema
export const invoiceItemSchema = z.object({
  id: z.number().int().positive().optional(),
  invoiceId: z.number().int().positive(),
  grn_id: z.number().int().positive(),
  grn_material_receipt_id: z.number().int().positive(),
  basicAmount: z.number().nullable().optional(),
  taxableValue: z.number().nullable().optional(),
  freightRatePerUnit: z.number().nullable().optional(),
  unloadingRatePerUnit: z.number().nullable().optional(),
});

export type InvoiceItem = z.infer<typeof invoiceItemSchema>;

// Tax Detail Schema
export const taxDetailSchema = z.object({
  id: z.number().int().positive().optional(),
  cgstRate: z.number().nullable().optional(),
  cgstAmount: z.number().nullable().optional(),
  sgstRate: z.number().nullable().optional(),
  sgstAmount: z.number().nullable().optional(),
  igstRate: z.number().nullable().optional(),
  igstAmount: z.number().nullable().optional(),
  totalTax: z.number().nullable().optional(),
  invoiceId: z.number().int().positive().nullable().optional(),
});

export type TaxDetail = z.infer<typeof taxDetailSchema>;

// Invoice Amount Summary Schema
export const invoiceAmountSummarySchema = z.object({
  id: z.number().int().positive().optional(),
  goodsValue: z.number().nullable().optional(),
  taxableValue: z.number().nullable().optional(),
  freightAmount: z.number().nullable().optional(),
  unloadingAmount: z.number().nullable().optional(),
  roundOff: z.number().nullable().optional(),
  totalTaxAmount: z.number().nullable().optional(),
  totalInvoiceValue: z.number().nullable().optional(),
  amountInWords: z.string().min(1),
  invoiceId: z.number().int().positive().nullable().optional(),
});

export type InvoiceAmountSummary = z.infer<typeof invoiceAmountSummarySchema>;

// Transport Detail Schema
export const transportDetailSchema = z.object({
  id: z.number().int().positive().optional(),
  transporterName: z.string().min(1),
  transporterGstin: z.string().nullable().optional(),
  vehicleNumber: z.string().nullable().optional(),
  wagonNumber: z.string().nullable().optional(),
  transportMode: z.string().min(1), // ROAD / RAIL
  lrRrNo: z.string().nullable().optional(),
  lrRrDate: z.date().nullable().optional(),
  dispatchFrom: z.string().nullable().optional(),
  destination: z.string().nullable().optional(),
  distanceKm: z.number().int().nullable().optional(),
  invoiceId: z.number().int().positive().nullable().optional(),
});

export type TransportDetail = z.infer<typeof transportDetailSchema>;

// Invoice Audit Schema
export const invoiceAuditSchema = z.object({
  id: z.number().int().positive().optional(),
  preparedBy: z.string().nullable().optional(),
  checkedBy: z.string().nullable().optional(),
  authorizedBy: z.string().nullable().optional(),
  declaration: z.string().nullable().optional(),
  termsConditions: z.string().nullable().optional(),
  invoiceId: z.number().int().positive().nullable().optional(),
});

export type InvoiceAudit = z.infer<typeof invoiceAuditSchema>;

// Invoice Schema
export const invoiceSchema = z.object({
  id: z.number().int().positive().optional(),
  invoiceNumber: z.string().min(1),
  invoiceDate: z.date().or(z.string().pipe(z.coerce.date())),
  invoiceType: z.string().min(1),
  reverseCharge: z.boolean().default(false),
  currency: z.string().default('INR'),
  po_id: z.number().int().positive(),
  sellerId: z.number().int().positive(),
  consigneeId: z.number().int().positive().nullable().optional(),
  taxDetailId: z.number().int().positive().nullable().optional(),
  amountSummaryId: z.number().int().positive().nullable().optional(),
  transportDetailId: z.number().int().positive().nullable().optional(),
  auditDetailId: z.number().int().positive().nullable().optional(),
  buyer: z.string().nullable().optional(),
  invoiceAmountSummaryId: z.number().int().positive().nullable().optional(),
  invoiceAuditId: z.number().int().positive().nullable().optional(),
  userId: z.number().int().positive().nullable().optional(),

  // Nested relations (optional for create/read)
  taxDetail: taxDetailSchema.optional(),
  amountSummary: invoiceAmountSummarySchema.optional(),
  transportDetail: transportDetailSchema.optional(),
  auditDetail: invoiceAuditSchema.optional(),
  items: z.array(invoiceItemSchema).optional(),

  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type Invoice = z.infer<typeof invoiceSchema>;
