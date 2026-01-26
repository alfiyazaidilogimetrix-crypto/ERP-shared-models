import { PrismaClient } from '../generated/client/client';
import { PrismaPg } from '@prisma/adapter-pg';
import * as fs from 'fs';
import * as path from 'path';

// 1. Construct the Connection String manually (Mimicking Sequelize's logic)
// Prisma requires a connection string, whereas Sequelize takes an object.
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

const connectionString = `postgresql://${pgUser}:${pgPass}@${pgHost}:${pgPort}/${pgDb}`;

// 2. Setup SSL (Exactly like your Sequelize code)
// Using 'CERTIFICATES_PATH' to match your working Sequelize config
const sslCertPath = process.env.CERTIFICATES_PATH;

let sslConfig: any = {
  rejectUnauthorized: false,
};

if (sslCertPath) {
  const resolvedPath = path.resolve(sslCertPath);
  if (fs.existsSync(resolvedPath)) {
    try {
      sslConfig.ca = fs.readFileSync(resolvedPath, 'utf8');
      console.log('✅ SSL Certificate loaded from CERTIFICATES_PATH');
    } catch (err) {
      console.warn('⚠️ Failed to read SSL certificate:', err);
    }
  } else {
    console.warn(
      '⚠️ SSL Certificate path specified but file not found:',
      resolvedPath,
    );
  }
}

// 3. Initialize Adapter with the dynamic string
const adapter = new PrismaPg({
  connectionString: connectionString,
  ssl: sslConfig,
});

// 4. Initialize Client
const prisma = new PrismaClient({ adapter });

// 5. Test Connection (Mimicking your Sequelize testConnection)
async function testConnection() {
  try {
    await prisma.$connect();
    console.log('✅ Prisma connection has been established successfully.');
  } catch (error) {
    console.error('❌ Unable to connect to the database:', error);
    throw error;
  }
}

export default prisma;
export { testConnection };
