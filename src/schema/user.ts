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

export const updateUserProfileSchema = z.object({
  name: z.string().min(3).max(30).optional(),
  mobileNumber: z.string().optional(),
  fileId: z.number().int().nullable().optional(),
});

export const updateUserPasswordSchema = z.object({
  currentPassword: z.string(),
  newPassword: z.string().min(8).max(20).regex(
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,20}$/,
    "Password must contain at least one uppercase letter, one lowercase letter, and one number"
  ),
});

export type IUserRegister = z.infer<typeof userRegisterSchema>;
export type IUserLogin = z.infer<typeof userLoginSchema>;
export type IUpdateUserProfile = z.infer<typeof updateUserProfileSchema>;
export type IUpdateUserPassword = z.infer<typeof updateUserPasswordSchema>;
