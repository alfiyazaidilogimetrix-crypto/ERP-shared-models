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
// IMPORTANT: We force 'connection_limit=5' here.
// This ensures Prisma only takes 5 slots, leaving the rest for Superuser.
const connectionString = `postgresql://${pgUser}:${pgPass}@${pgHost}:${pgPort}/${pgDb}?connection_limit=5`;

// 3. Setup SSL (Your existing logic)
const sslCertPath = process.env.CERTIFICATES_PATH;
let sslConfig: any = {
  rejectUnauthorized: false,
};

if (sslCertPath) {
  const resolvedPath = path.resolve(sslCertPath);
  if (fs.existsSync(resolvedPath)) {
    try {
      sslConfig.ca = fs.readFileSync(resolvedPath, 'utf8');
      console.log('✅ SSL Certificate loaded.');
    } catch (err) {
      console.warn('⚠️ Failed to read SSL certificate:', err);
    }
  }
}

const adapter = new PrismaPg({
  connectionString: connectionString,
  ssl: sslConfig,
});

// 4. Singleton Pattern (Ensures only 1 instance)
const prismaClientSingleton = () => {
  return new PrismaClient({
    adapter,
    log: ['warn', 'error'],
  });
};

declare global {
  var prisma: undefined | ReturnType<typeof prismaClientSingleton>;
}

const prisma = global.prisma ?? prismaClientSingleton();

if (process.env.NODE_ENV !== 'production') global.prisma = prisma;

process.on('beforeExit', async () => {
  await prisma.$disconnect();
});

export default prisma;

export async function testConnection() {
  try {
    await prisma.$connect();
    console.log('✅ Prisma connection established.');
  } catch (error) {
    console.error('❌ Connection failed:', error);
    throw error;
  }
}
