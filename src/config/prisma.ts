import { PrismaClient } from '../generated/client/client';
import { PrismaPg } from '@prisma/adapter-pg';
import * as fs from 'fs';
import * as path from 'path';

const pgUser = process.env.PG_USER;
const pgPass = process.env.PG_PASS;
const pgHost = process.env.PG_HOST;
const pgPort = process.env.PG_PORT || '5432';
const pgDb = process.env.PG_DB;

if (!pgUser || !pgHost || !pgDb) {
  throw new Error('Missing database environment variables.');
}

// 1. Limit connection_limit to a small number (e.g., 5)
// This ensures you never exceed the DB limit, even if you have 100 users.
const connectionString = `postgresql://${pgUser}:${pgPass}@${pgHost}:${pgPort}/${pgDb}?connection_limit=5`;

// 2. SSL Setup
const sslCertPath = process.env.CERTIFICATES_PATH;
let sslConfig: any = {
  rejectUnauthorized: false, // Essential for DigitalOcean managed DBs usually
};

if (sslCertPath) {
  const resolvedPath = path.resolve(sslCertPath);
  if (fs.existsSync(resolvedPath)) {
    try {
      sslConfig.ca = fs.readFileSync(resolvedPath, 'utf-8');
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

// 3. Singleton Pattern
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

// 4. Aggressive Cleanup (Prevents "Remaining slots reserved" error on restart)
process.on('beforeExit', async () => {
  await prisma.$disconnect();
});

// Also disconnect on SIGINT (Ctrl+C)
process.on('SIGINT', async () => {
  await prisma.$disconnect();
  process.exit(0);
});

export default prisma;
