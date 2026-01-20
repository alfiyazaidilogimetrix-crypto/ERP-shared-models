import { z } from 'zod';

// DPR Material Consumption Schema
export const dprMaterialConsumptionSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  stock_id: z.number().int().positive(),
  quantity: z.number().nonnegative(),
  unit: z.string(),
  rate: z.number().nonnegative(),
  amount: z.number().nonnegative(),
  chainage_from: z.string().nullable().optional(),
  chainage_to: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

export type DPRMaterialConsumption = z.infer<
  typeof dprMaterialConsumptionSchema
>;

// DPR Labour Schema (for linking labour to DPRLabourConsumption)
export const dprLabourSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_labour_consumption_id: z.number().int().positive().optional(),
  labour_id: z.number().int().positive(),
});

export type DPRLabour = z.infer<typeof dprLabourSchema>;

// DPR Labour Consumption Schema
export const dprLabourConsumptionSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  skill: z.string(),
  hours: z.number().nonnegative(),
  charges: z.number().nonnegative(),
  chainage_from: z.string().nullable().optional(),
  chainage_to: z.string().nullable().optional(),
  labours: z
    .array(dprLabourSchema.omit({ dpr_labour_consumption_id: true }))
    .optional(),
  created_at: z.date().optional(),
});

export type DPRLabourConsumption = z.infer<typeof dprLabourConsumptionSchema>;

// DPR Machinery Usage Schema
export const dprMachineryUsageSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  machine_code: z.string().nullable().optional(),
  machine_name: z.string(),
  chainage_from: z.string().nullable().optional(),
  chainage_to: z.string().nullable().optional(),
  working_hours: z.number().nonnegative(),
  fuel_type: z.string().nullable().optional(),
  fuel_consumed: z.string().nullable().optional(),
  fuel_amount: z.string().nullable().optional(),
  created_at: z.date().optional(),
});

export type DPRMachineryUsage = z.infer<typeof dprMachineryUsageSchema>;

// DPR File Schema
export const dprFileSchema = z.object({
  id: z.number().int().positive().optional(),
  dpr_id: z.number().int().positive().optional(),
  file_id: z.number().int().positive(),
});

export type DPRFile = z.infer<typeof dprFileSchema>;

// Base DPR Schema (for reading/updating)
export const dprSchema = z.object({
  id: z.number().int().positive().optional(),
  date: z.date().or(z.string().pipe(z.coerce.date())),
  project_id: z.number().int().positive(),
  weather_conditions: z.string(),
  safety_incidents: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  submitted_by: z.number().int().positive(),
  material_cost: z.number().nonnegative(),
  labour_cost: z.number().nonnegative(),
  machinery_cost: z.number().nonnegative(),
  total_cost: z.number().nonnegative(),
  materials: z.array(dprMaterialConsumptionSchema).optional(),
  labours: z.array(dprLabourConsumptionSchema).optional(),
  machinery: z.array(dprMachineryUsageSchema).optional(),
  dprfiles: z.array(dprFileSchema).optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type DPR = z.infer<typeof dprSchema>;

// // Create DPR Schema (for creating new DPR with optional file_ids and labour_ids)
// export const createDprSchema = z.object({
//   date: z.date().or(z.string().pipe(z.coerce.date())),
//   project_id: z.number().int().positive(),
//   weather_conditions: z.string(),
//   safety_incidents: z.string().nullable().optional(),
//   remarks: z.string().nullable().optional(),
//   submitted_by: z.number().int().positive(),
//   material_cost: z.number().nonnegative(),
//   labour_cost: z.number().nonnegative(),
//   machinery_cost: z.number().nonnegative(),
//   total_cost: z.number().nonnegative(),
//   materials: z.array(dprMaterialConsumptionSchema.omit({ dpr_id: true })).optional().default([]),
//   labour_consumptions: z.array(
//     dprLabourConsumptionSchema.omit({ dpr_id: true }).extend({
//       labour_ids: z.array(z.number().int().positive()).optional().default([]),
//     })
//   ).optional().default([]),
//   machinery: z.array(dprMachineryUsageSchema.omit({ dpr_id: true })).optional().default([]),
//   file_ids: z.array(z.number().int().positive()).optional().default([]),
// });

// export type CreateDPRInput = z.infer<typeof createDprSchema>;

// // Alternative Create DPR Schema with flat labour_ids (if you want labour_ids at root level)
// export const createDprSchemaWithFlatLabourIds = z.object({
//   date: z.date().or(z.string().pipe(z.coerce.date())),
//   project_id: z.number().int().positive(),
//   weather_conditions: z.string(),
//   safety_incidents: z.string().nullable().optional(),
//   remarks: z.string().nullable().optional(),
//   submitted_by: z.number().int().positive(),
//   material_cost: z.number().nonnegative(),
//   labour_cost: z.number().nonnegative(),
//   machinery_cost: z.number().nonnegative(),
//   total_cost: z.number().nonnegative(),
//   materials: z.array(dprMaterialConsumptionSchema.omit({ dpr_id: true })).optional().default([]),
//   labour_consumptions: z.array(dprLabourConsumptionSchema.omit({ dpr_id: true })).optional().default([]),
//   machinery: z.array(dprMachineryUsageSchema.omit({ dpr_id: true })).optional().default([]),
//   file_ids: z.array(z.number().int().positive()).optional().default([]),
//   labour_ids: z.array(z.number().int().positive()).optional().default([]),
// });

// export type CreateDPRInputWithFlatLabourIds = z.infer<typeof createDprSchemaWithFlatLabourIds>;

// // Update DPR Schema
// export const updateDprSchema = z.object({
//   date: z.date().or(z.string().pipe(z.coerce.date())).optional(),
//   project_id: z.number().int().positive().optional(),
//   weather_conditions: z.string().optional(),
//   safety_incidents: z.string().nullable().optional(),
//   remarks: z.string().nullable().optional(),
//   submitted_by: z.number().int().positive().optional(),
//   material_cost: z.number().nonnegative().optional(),
//   labour_cost: z.number().nonnegative().optional(),
//   machinery_cost: z.number().nonnegative().optional(),
//   total_cost: z.number().nonnegative().optional(),
//   materials: z.array(dprMaterialConsumptionSchema).optional(),
//   labour_consumptions: z.array(
//     dprLabourConsumptionSchema.extend({
//       labour_ids: z.array(z.number().int().positive()).optional(),
//     })
//   ).optional(),
//   machinery: z.array(dprMachineryUsageSchema).optional(),
//   file_ids: z.array(z.number().int().positive()).optional(),
// });

// export type UpdateDPRInput = z.infer<typeof updateDprSchema>;

// // Alternative Update DPR Schema with flat labour_ids
// export const updateDprSchemaWithFlatLabourIds = z.object({
//   date: z.date().or(z.string().pipe(z.coerce.date())).optional(),
//   project_id: z.number().int().positive().optional(),
//   weather_conditions: z.string().optional(),
//   safety_incidents: z.string().nullable().optional(),
//   remarks: z.string().nullable().optional(),
//   submitted_by: z.number().int().positive().optional(),
//   material_cost: z.number().nonnegative().optional(),
//   labour_cost: z.number().nonnegative().optional(),
//   machinery_cost: z.number().nonnegative().optional(),
//   total_cost: z.number().nonnegative().optional(),
//   materials: z.array(dprMaterialConsumptionSchema).optional(),
//   labour_consumptions: z.array(dprLabourConsumptionSchema).optional(),
//   machinery: z.array(dprMachineryUsageSchema).optional(),
//   file_ids: z.array(z.number().int().positive()).optional(),
//   labour_ids: z.array(z.number().int().positive()).optional(),
// });

// export type UpdateDPRInputWithFlatLabourIds = z.infer<typeof updateDprSchemaWithFlatLabourIds>;

// // DPR with relations Schema (for responses)
// export const dprWithRelationsSchema = dprSchema.extend({
//   materials: z.array(dprMaterialConsumptionSchema.extend({
//     stock: z.object({
//       id: z.number().int().positive(),
//       material_name: z.string(),
//       // Add other stock fields as needed
//     }).optional(),
//   })).optional(),
//   labours: z.array(dprLabourConsumptionSchema.extend({
//     labours: z.array(dprLabourSchema.extend({
//       labour: z.object({
//         id: z.number().int().positive(),
//         name: z.string(),
//         skill: z.string(),
//         contact: z.string().nullable(),
//         // Add other labour fields as needed
//       }).optional(),
//     })).optional(),
//   })).optional(),
//   machinery: z.array(dprMachineryUsageSchema).optional(),
//   dprfiles: z.array(dprFileSchema.extend({
//     file: z.object({
//       id: z.number().int().positive(),
//       filename: z.string(),
//       url: z.string(),
//       mimetype: z.string(),
//       size: z.number().int(),
//       created_at: z.date(),
//     }).optional(),
//   })).optional(),
//   project: z.object({
//     id: z.number().int().positive(),
//     project_name: z.string(),
//     // Add other project fields as needed
//   }).optional(),
//   user: z.object({
//     id: z.number().int().positive(),
//     name: z.string(),
//     email: z.string(),
//     // Add other user fields as needed
//   }).optional(),
// });

// export type DPRWithRelations = z.infer<typeof dprWithRelationsSchema>;

// // Simplified DPR response (for lists)
// export const dprListItemSchema = z.object({
//   id: z.number().int().positive(),
//   date: z.date(),
//   project_id: z.number().int().positive(),
//   weather_conditions: z.string(),
//   total_cost: z.number().nonnegative(),
//   project: z.object({
//     project_name: z.string(),
//   }).optional(),
//   user: z.object({
//     name: z.string(),
//   }).optional(),
//   created_at: z.date(),
// });

// export type DPRListItem = z.infer<typeof dprListItemSchema>;
