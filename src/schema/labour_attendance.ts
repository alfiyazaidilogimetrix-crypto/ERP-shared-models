import { z } from 'zod';

export const labourAttendanceActivitySchema = z.object({
  id: z.string().uuid().optional(),
  no_of_labour: z.number().int().nonnegative().nullable().optional(),
  per_labour_cost: z.number().nonnegative().nullable().optional(),
  total_working_hours: z.number().int().nonnegative().nullable().optional(),
  total_labour_cost: z.number().nonnegative().nullable().optional(),
  overtime_cost_per_hour: z.number().nonnegative().nullable().optional(),
  overtime_hours: z.number().int().nonnegative().nullable().optional(),
  total_overtime_cost: z.number().nonnegative().nullable().optional(),
  total_cost: z.number().nonnegative().nullable().optional(),
  activity_id: z.number().int().positive(),
  labour_attendance_id: z.number().int().positive().optional(),
});

export type LabourAttendanceActivity = z.infer<typeof labourAttendanceActivitySchema>;

export const labourAttendanceSchema = z.object({
  id: z.number().int().positive().optional(),
  project_id: z.number().int().positive(),
  date: z.date().or(z.string().pipe(z.coerce.date())),
  team_name: z.string(),
  company_id: z.number().int().positive(),
  head_office_id: z.number().int().positive(),
  branch_office_id: z.number().int().positive(),
  labourAttendanceActivities: z.array(labourAttendanceActivitySchema).optional(),
  created_at: z.date().optional(),
  updated_at: z.date().optional(),
});

export type LabourAttendance = z.infer<typeof labourAttendanceSchema>;
