import { z } from 'zod';

// Base schemas
export const inventoryManagerSchema = z.object({
  id: z.number().int().positive().optional(),
  userId: z.number().int().positive(),
  location_id: z.number().int().positive(),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const inventoryStockEntrySchema = z.object({
  id: z.number().int().positive().optional(),
  inventoryId: z.number().int().positive(),
  stockId: z.number().int().positive(),
});

export type InventoryManager = z.infer<typeof inventoryManagerSchema>;
export type InventoryStockEntry = z.infer<typeof inventoryStockEntrySchema>;
