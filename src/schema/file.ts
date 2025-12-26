import { z } from "zod";

export const fileSchema = z.object({
  id: z.number().int().positive().optional(),
  filename: z.string(),
  originalName: z.string(),
  mimeType: z.string(),
  size: z.number().int(),
  filePath: z.string(),
  fileContent: z.any(), // Buffer/Bytes
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export type File = z.infer<typeof fileSchema>;
