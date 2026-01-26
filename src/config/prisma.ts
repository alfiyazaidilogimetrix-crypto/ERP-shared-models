import { PrismaClient } from '../generated/client/client';
import { PrismaPg } from '@prisma/adapter-pg';
import * as fs from 'fs';
import * as path from 'path';

// 1. Load Environment Variables
const pgUser = process.env.PG_USER;
const pgPass = process.env.PG_PASS;
const pgHost = process.env.PG_HOST;
const pgPort = process.env.PG_PORT || '5432';
const pgDb = process.env.PG_DB;

if (!pgUser || !pgHost || !pgDb) {
  throw new Error(
    'Missing database environment variables (PG_USER, PG_HOST, PG_DB).',
  );
}

// 2. Construct Connection String
// We ADD 'connection_limit=5' to the URL string itself.
// This ensures Prisma knows to only keep 5 connections open, even if we restart frequently.
const connectionString = `postgresql://${pgUser}:${pgPass}@${pgHost}:${pgPort}/${pgDb}?connection_limit=5`;

// 3. Setup SSL
const sslCertPath = process.env.CERTIFICATES_PATH;
let sslConfig: any = {
  rejectUnauthorized: false, // Required for DO Managed DBs usually
};

if (sslCertPath) {
  const resolvedPath = path.resolve(sslCertPath);
  if (fs.existsSync(resolvedPath)) {
    try {
      sslConfig.ca = fs.readFileSync(resolvedPath, 'utf8');
      // console.log('✅ SSL Certificate loaded.'); // Optional: Commented out to reduce log noise
    } catch (err) {
      console.warn('⚠️ Failed to read SSL certificate:', err);
    }
  }
}

// 4. Initialize Adapter
const adapter = new PrismaPg({
  connectionString: connectionString,
  ssl: sslConfig,
});

// 5. Singleton Pattern
// This logic prevents "Too many connections" by reusing the same instance.
const prismaClientSingleton = () => {
  return new PrismaClient({
    adapter,
    log: ['warn', 'error'], // Only log errors/warnings to save resources
  });
};

// Extend global type
declare global {
  var prisma: undefined | ReturnType<typeof prismaClientSingleton>;
}

const prisma = global.prisma ?? prismaClientSingleton();

// In development, attach to global so hot-reloads don't create new clients
if (process.env.NODE_ENV !== 'production') global.prisma = prisma;

// 6. Safe Disconnect
// Ensure connections are closed when the script stops (prevents zombie connections)
process.on('beforeExit', async () => {
  await prisma.$disconnect();
});

export default prisma;

// 7. Test Connection Function (Kept if you need it)
export async function testConnection() {
  try {
    await prisma.$connect();
    console.log('✅ Prisma connection established successfully.');
  } catch (error) {
    console.error('❌ Unable to connect to the database:', error);
    throw error;
  }
}
