// Environment variables type definition
export interface AppEnv {
  // Database
  DATABASE_URL: string;
  PORT: string;
}

// Type-safe environment loader with validation
export function loadEnv(): AppEnv {
  const requiredEnvs: (keyof AppEnv)[] = ['DATABASE_URL', 'PORT'];

  // Check for missing environment variables
  const missingEnvs = requiredEnvs.filter((env) => !process.env[env]);

  if (missingEnvs.length > 0) {
    throw new Error(
      `Missing required environment variables: ${missingEnvs.join(', ')}`,
    );
  }

  return {
    DATABASE_URL: process.env.DATABASE_URL!,
    PORT: process.env.PORT!,
  };
}

// Usage with Hono
// Option 1: Using with Hono bindings
export type HonoEnv = {
  Bindings: AppEnv;
};

// Option 2: Global env instance
export const env = loadEnv();
