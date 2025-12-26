import { z } from "zod";

export const providerSchema = z.enum(["credentials", "google"]);

export const receiptStatusSchema = z.enum(["RECEIVED", "ACCEPTED", "REJECTED"]);

export const poStatusSchema = z.enum(["DRAFT", "ISSUED", "PARTIALLY_DELIVERED", "DELIVERED", "CANCELLED", "CLOSED"]);

export const transportModeSchema = z.enum(["ROAD", "RAIL", "SEA", "AIR", "SELF_PICKUP"]);

export const prStatusSchema = z.enum(["DRAFT", "SUBMITTED", "APPROVED", "REJECTED", "CLOSED"]);

export const urgencyLevelSchema = z.enum(["LOW", "MEDIUM", "HIGH", "CRITICAL"]);

export const projectTypeSchema = z.enum(["HAM", "EPC", "BOT", "OTHER"]);

export const projectStatusSchema = z.enum(["PLANNED", "IN_PROGRESS", "ON_HOLD", "COMPLETED", "CANCELLED"]);

export const dieselTransactionTypeSchema = z.enum(["DIESEL_RECEIPT", "DIESEL_ISSUE"]);

export const labourStatusSchema = z.enum(["ACTIVE", "INACTIVE", "LEFT", "BLACKLISTED"]);

export const labourTypeSchema = z.enum(["DIRECT", "CONTRACT"]);

export const vendorStatusSchema = z.enum(["ACTIVE", "INACTIVE", "SUSPENDED"]);

export const vendorTypeSchema = z.enum(["DIRECT", "INVENTORY"]);

export const supplyStatusSchema = z.enum(["PENDING", "APPROVED", "IN_TRANSIT", "DELIVERED", "REJECTED"]);
