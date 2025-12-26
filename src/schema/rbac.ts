import { z } from "zod";

// Role Schemas
export const roleCreateSchema = z.object({
  name: z.string().min(1),
  description: z.string().optional(),
  permissionIds: z.array(z.number()).optional(),
});

export const roleUpdateSchema = z.object({
  name: z.string().optional(),
  description: z.string().optional(),
  permissionIds: z.array(z.number()).optional(),
});

export const assignRoleToUserSchema = z.object({
  userId: z.number(),
  roleId: z.number(),
});

export type ICreateRole = z.infer<typeof roleCreateSchema>;
export type IUpdateRole = z.infer<typeof roleUpdateSchema>;
export type IAssignRoleToUser = z.infer<typeof assignRoleToUserSchema>;

// Permission Schemas
export const permissionCreateSchema = z.object({
  action: z.array(z.string()),
  moduleIds: z.array(z.number()).optional(),
});

export const permissionUpdateSchema = z.object({
  action: z.array(z.string()).optional(),
  moduleIds: z.array(z.number()).optional(),
});

export type ICreatePermission = z.infer<typeof permissionCreateSchema>;
export type IUpdatePermission = z.infer<typeof permissionUpdateSchema>;

// Module Schemas
export const moduleCreateSchema = z.object({
  Name: z.string().min(1),
  description: z.string().optional(),
});

export const moduleUpdateSchema = z.object({
  Name: z.string().optional(),
  description: z.string().optional(),
});

export type ICreateModule = z.infer<typeof moduleCreateSchema>;
export type IUpdateModule = z.infer<typeof moduleUpdateSchema>;
