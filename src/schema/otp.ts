import { z } from "zod";

export const generateOtpSchema = z
  .object({
    email: z.string().email(),
  });

export const verifyOtpSchema = z
  .object({
    token: z.string(),
    otp: z.string(),
  });

export const resendOtpSchema = z
  .object({
    token: z.string(),
  });

export type IGenerateOtp = z.infer<typeof generateOtpSchema>;
export type IVerifyOtp = z.infer<typeof verifyOtpSchema>;
export type IResendOtp = z.infer<typeof resendOtpSchema>;
