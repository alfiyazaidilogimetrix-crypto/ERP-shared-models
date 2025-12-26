import { z } from "zod";

export const fileUpdateSchema = z.object({
  filename: z.string().optional(),
  originalName: z.string().optional(),
  mimeType: z.string().optional(),
});

export const deleteMultipleFilesSchema = z.object({
  ids: z.array(z.number()),
});

export const fileQuerySchema = z.object({
  id: z.number().int().optional(),
  filename: z.string().optional(),
  originalName: z.string().optional(),
  mimeType: z.string().optional(),
  size: z.number().int().optional(),
  filePath: z.string().optional(),
  mimeTypes: z.array(z.string()).optional(),
  minSize: z.number().int().optional(),
  maxSize: z.number().int().optional(),
  includeContent: z.boolean().optional(),
});

export type IFileQuery = z.infer<typeof fileQuerySchema>;
export type IFileUpdate = z.infer<typeof fileUpdateSchema>;
export type IDeleteMultipleFiles = z.infer<typeof deleteMultipleFilesSchema>;
