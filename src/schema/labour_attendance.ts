import { z } from 'zod';
import { attendanceStatusSchema } from './enums';

export const labourAttendanceSchema = z.object({
  id: z.string().uuid().optional(),
  labour_id: z.number().int().positive(),
  project_id: z.number().int().positive(),
  date: z.date(),
  check_in_time: z.date().nullable().optional(),
  check_out_time: z.date().nullable().optional(),
  total_working_hours: z.number().nonnegative().nullable().optional(),
  field_working_hours: z.number().nonnegative().nullable().optional(),
  overtime_hours: z.number().nonnegative().nullable().optional(),
  status: attendanceStatusSchema,
  chainage_from: z.string().nullable().optional(),
  chainage_to: z.string().nullable().optional(),
  remarks: z.string().nullable().optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type LabourAttendance = z.infer<typeof labourAttendanceSchema>;
