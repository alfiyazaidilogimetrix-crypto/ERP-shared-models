import { z } from 'zod';

export const chainageConsumptionLedgerSchema = z.object({
  id: z.number().int().positive().optional(),
  chainage_data: z.any(), // or use z.record(z.any()) for more specificity
  projectId: z.number().int().positive(),
  project: z.any().optional(), // You might want to create a more specific Project schema
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type ChainageConsumptionLedger = z.infer<
  typeof chainageConsumptionLedgerSchema
>;

// If you want a more strict JSON schema for chainage_data, you could define it separately:
// export const chainageDataSchema = z.object({
//   // Define the expected structure of your JSON data here
//   // Example:
//   // chainage: z.number().positive(),
//   // consumption: z.number().positive(),
//   // unit: z.string().optional(),
//   // ... other JSON fields
// }).passthrough(); // .passthrough() allows additional unknown properties

// // Then update the main schema:
// export const chainageConsumptionLedgerSchemaWithStrictJson = z.object({
//   id: z.number().int().positive().optional(),
//   chainage_data: chainageDataSchema,
//   projectId: z.number().int().positive(),
//   project: z.any().optional(),
//   createdAt: z.date().optional(),
//   updatedAt: z.date().optional(),
// });

// export type ChainageConsumptionLedgerWithStrictJson = z.infer<typeof chainageConsumptionLedgerSchemaWithStrictJson>;
