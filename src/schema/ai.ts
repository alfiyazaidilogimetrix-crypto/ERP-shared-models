import { z } from 'zod';

export const aiAlertSeveritySchema = z.enum(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']);
export const aiAlertStatusSchema = z.enum(['OPEN', 'IN_REVIEW', 'RESOLVED', 'DISMISSED']);
export const aiActionStatusSchema = z.enum([
  'DRAFTED',
  'PENDING_CONFIRMATION',
  'CONFIRMED',
  'EXECUTED',
  'REJECTED',
  'FAILED'
]);

export const aiConversationSchema = z.object({
  id: z.string().uuid().optional(),
  user_id: z.number(),
  company_id: z.number(),
  project_id: z.number().nullable().optional(),
  title: z.string().default('New Conversation'),
  module: z.string().default('General'),
  language: z.string().default('en'),
  is_archived: z.boolean().default(false),
  created_at: z.date().optional(),
  updated_at: z.date().optional()
});

export const aiMessageSchema = z.object({
  id: z.string().uuid().optional(),
  conversation_id: z.string().uuid(),
  sender: z.enum(['user', 'assistant', 'system']),
  content: z.string(),
  rich_payload: z.string().nullable().optional(),
  references: z.string().nullable().optional(),
  actions: z.string().nullable().optional(),
  language: z.string().default('en'),
  created_at: z.date().optional()
});

export const aiAlertSchema = z.object({
  id: z.string().uuid().optional(),
  company_id: z.number(),
  project_id: z.number().nullable().optional(),
  module: z.string(),
  severity: aiAlertSeveritySchema.default('MEDIUM'),
  title: z.string(),
  description: z.string(),
  supporting_records: z.string().nullable().optional(),
  recommended_action: z.string().nullable().optional(),
  status: aiAlertStatusSchema.default('OPEN'),
  assigned_to: z.number().nullable().optional(),
  reviewer_notes: z.string().nullable().optional(),
  detection_date: z.date().optional()
});

export const aiPredictionSchema = z.object({
  id: z.string().uuid().optional(),
  company_id: z.number(),
  project_id: z.number().nullable().optional(),
  prediction_type: z.string(),
  target_entity: z.string(),
  forecast_data: z.string(),
  confidence_score: z.number().min(0).max(1),
  assumptions: z.string().nullable().optional(),
  data_points_count: z.number().default(0)
});

export const aiActionLogSchema = z.object({
  id: z.string().uuid().optional(),
  company_id: z.number(),
  project_id: z.number().nullable().optional(),
  user_id: z.number(),
  action_type: z.string(),
  action_payload: z.string(),
  status: aiActionStatusSchema.default('DRAFTED'),
  execution_result: z.string().nullable().optional()
});

