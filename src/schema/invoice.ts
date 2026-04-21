import { z } from 'zod';

// Invoice Seller Snapshot Schema
export const invoiceSellerSchema = z.object({
  id: z.number().int().positive().optional(),
  invoice_id: z.number().int().positive().optional(),
  name: z.string().min(1),
  address: z.string().min(1),
  godown_address: z.string().nullable().optional(),
  phone: z.array(z.string()).default([]),
  email: z.string().email().nullable().optional(),
  gstin: z.string().nullable().optional(),
  state: z.string().nullable().optional(),
  state_code: z.string().nullable().optional(),
  udyog_aadhar: z.string().nullable().optional(),
  pan: z.string().nullable().optional(),
});

export type InvoiceSeller = z.infer<typeof invoiceSellerSchema>;

// Invoice Buyer Snapshot Schema
export const invoiceBuyerSchema = z.object({
  id: z.number().int().positive().optional(),
  invoice_id: z.number().int().positive().optional(),
  name: z.string().min(1),
  address: z.string().nullable().optional(),
  gstin: z.string().nullable().optional(),
  state: z.string().nullable().optional(),
  state_code: z.string().nullable().optional(),
});

export type InvoiceBuyer = z.infer<typeof invoiceBuyerSchema>;

// Invoice Consignee Snapshot Schema
export const invoiceConsigneeSchema = z.object({
  id: z.number().int().positive().optional(),
  invoice_id: z.number().int().positive().optional(),
  name: z.string().min(1),
  address: z.string().nullable().optional(),
  gstin: z.string().nullable().optional(),
  state: z.string().nullable().optional(),
  state_code: z.string().nullable().optional(),
});

export type InvoiceConsignee = z.infer<typeof invoiceConsigneeSchema>;

// Invoice Tax Snapshot Schema
export const invoiceTaxSchema = z.object({
  id: z.number().int().positive().optional(),
  invoice_id: z.number().int().positive().optional(),
  taxable_amount: z.number().nullable().optional(),
  cgst_rate: z.number().nullable().optional(),
  cgst_amount: z.number().nullable().optional(),
  sgst_rate: z.number().nullable().optional(),
  sgst_amount: z.number().nullable().optional(),
  total_tax: z.number().nullable().optional(),
  tax_in_words: z.string().nullable().optional(),
});

export type InvoiceTax = z.infer<typeof invoiceTaxSchema>;

// Invoice Bank Details Snapshot Schema
export const invoiceBankDetailsSchema = z.object({
  id: z.number().int().positive().optional(),
  invoice_id: z.number().int().positive().optional(),
  account_holder_name: z.string().nullable().optional(),
  bank_name: z.string().nullable().optional(),
  account_number: z.string().nullable().optional(),
  ifsc_code: z.string().nullable().optional(),
  branch: z.string().nullable().optional(),
});

export type InvoiceBankDetails = z.infer<typeof invoiceBankDetailsSchema>;

// Base Invoice Schema
export const invoiceSchema = z.object({
  id: z.number().int().positive().optional(),
  invoice_number: z.string().min(1),
  invoice_date: z.date().or(z.string().pipe(z.coerce.date())),
  invoice_type: z.string().min(1),
  irn: z.string().nullable().optional(),
  ack_no: z.string().nullable().optional(),
  ack_date: z.date().or(z.string().pipe(z.coerce.date())).nullable().optional(),
  eway_bill_no: z.string().nullable().optional(),
  place_of_supply: z.string().nullable().optional(),
  destination: z.string().nullable().optional(),
  vehicle_number: z.string().nullable().optional(),
  total_quantity: z.number().nullable().optional(),
  total_amount: z.number().nullable().optional(),
  round_off: z.number().nullable().optional(),
  amount_in_words: z.string().nullable().optional(),
  company_id: z.number().int().positive(),
  grn_id: z.number().int().positive(),
  vendor_id: z.number().int().positive(),

  // Nested relations (snapshots)
  seller: invoiceSellerSchema.optional(),
  buyer: invoiceBuyerSchema.optional(),
  consignee: invoiceConsigneeSchema.optional(),
  tax: invoiceTaxSchema.optional(),
  bank_details: invoiceBankDetailsSchema.optional(),

  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type Invoice = z.infer<typeof invoiceSchema>;

// Create Invoice Schema
export const createInvoiceSchema = invoiceSchema.omit({
  id: true,
  created_at: true,
  updated_at: true,
});

export type CreateInvoice = z.infer<typeof createInvoiceSchema>;
