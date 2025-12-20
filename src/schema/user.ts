import { z } from "zod";

export const userRegisterSchema = z
  .object({
    name: z.string().min(3).max(30),
    email: z.string().email(),
    password: z
      .string()
      .min(8)
      .max(20)
      .regex(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,20}$/,
        "Password must contain at least one uppercase letter, one lowercase letter, and one number"
      ),
  });

export const userLoginSchema = z
  .object({
    email: z.string().email(),
    password: z.string(),
  });

export type IUserRegister = z.infer<typeof userRegisterSchema>;
export type IUserLogin = z.infer<typeof userLoginSchema>;
