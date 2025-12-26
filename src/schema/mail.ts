import { z } from "zod";

export const sendEmailSchema = z.object({
  to: z.union([z.string().email(), z.array(z.string().email())]),
  subject: z.string().min(1, "Subject is required"),
  text: z.string().optional(),
  html: z.string().optional(),
  bcc: z.union([z.string().email(), z.array(z.string().email())]).optional(),
});

export type SendEmail = z.infer<typeof sendEmailSchema>;
