import { z } from "zod";

export const headOfficeSchema = z.object({
  id: z.number().int().positive().optional(),
  company_id: z.number().int().positive(),
  office_name: z.string().min(1, "Office name is required"),
  office_id: z.string().min(1, "Office ID is required"),
  address: z.string().min(1, "Address is required"),
  pincode: z.string().min(1, "Pincode is required"),
  state: z.string().min(1, "State is required"),
  city: z.string().min(1, "City is required"),
  phone_number: z.string().min(1, "Phone number is required"),
  mail_id: z.string().email("Invalid email address"),
  office_incharge_name: z.string().nullable().optional(),
  office_incharge_phone_number: z.string().nullable().optional(),
  office_incharge_mail_id: z.string().email("Invalid email address").nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type HeadOffice = z.infer<typeof headOfficeSchema>;
