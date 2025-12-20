import { z } from "zod";

export const sendMailSchema = z
  .object({
    subject: z.string(),
    to: z.string().email(),
    from: z.string().email().optional(),
    cc: z.array(z.string().email()).optional(),
    html: z.string(),
  });

export type ISendMail = z.infer<typeof sendMailSchema>;
