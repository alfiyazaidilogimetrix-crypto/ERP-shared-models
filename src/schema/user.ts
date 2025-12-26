import { z } from "zod";

export const userSchema = z.object({
  id: z.number().int().positive().optional(),
  name: z.string().min(2, "Name must be at least 2 characters"),
  email: z.string().email("Invalid email address"),
  emailVerified: z.boolean().default(false),
  password: z.string().min(8, "Password must be at least 8 characters"),
  fileId: z.number().int().nullable().optional(),
  original_password: z.string().nullable().optional(),
  mobileNumber: z.string().nullable().optional(),
  roleId: z.number().int().nullable().optional(),
  provider: z.enum(["credentials", "google"]).default("credentials"),
  createdAt: z.date().optional(),
  updatedAt: z.date().optional(),
});

export const userRegisterSchema = z.object({
  name: z.string().min(2, "Name must be at least 2 characters"),
  email: z.string().email("Invalid email address"),
  password: z.string().min(8, "Password must be at least 8 characters"),
  mobileNumber: z.string().optional(),
});

export const userLoginSchema = z.object({
  email: z.string().email("Invalid email address"),
  password: z.string().min(1, "Password is required"),
});

export type User = z.infer<typeof userSchema>;
export type UserRegister = z.infer<typeof userRegisterSchema>;
export type UserLogin = z.infer<typeof userLoginSchema>;
