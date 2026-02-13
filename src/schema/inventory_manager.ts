import { z } from 'zod';

// Base schemas
export const inventoryManagerSchema = z.object({
  id: z.number().int().positive().optional(),
  userId: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const inventoryStockEntrySchema = z.object({
  id: z.number().int().positive().optional(),
  inventoryId: z.number().int().positive(),
  stockId: z.number().int().positive(),
});

export const inventoryHistorySchema = z.object({
  id: z.number().int().positive().optional(),
  manager_id: z.number().int().positive(),
  project_id: z.number().int().positive(),
  total_amount: z.number().nullable().optional(),
  items_data: z.any(), // Using z.any() for Json type
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type InventoryHistory = z.infer<typeof inventoryHistorySchema>;
export type InventoryManager = z.infer<typeof inventoryManagerSchema>;
export type InventoryStockEntry = z.infer<typeof inventoryStockEntrySchema>;
