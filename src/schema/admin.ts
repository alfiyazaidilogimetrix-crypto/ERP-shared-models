import { z } from "zod";

export const adminRegisterSchema = z
  .object({
    name: z.string().min(3).max(30),
    email: z.string().email(),
    emailVerified: z.boolean().optional(),
    password: z
      .string()
      .min(8)
      .max(20)
      .regex(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,20}$/,
        "Password must contain at least one uppercase letter, one lowercase letter, and one number"
      ),
  });

export const adminLoginSchema = z
  .object({
    email: z.string().email(),
    password: z.string(),
  });

export type IAdminRegister = z.infer<typeof adminRegisterSchema>;
export type IAdminLogin = z.infer<typeof adminLoginSchema>;
