// import { PrismaClient } from '../generated/client/client';
// import { PrismaPg } from '@prisma/adapter-pg';

// const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
// const prisma = new PrismaClient({ adapter });

// export default prisma;

import * as fs from 'fs';
import { PrismaClient } from '../generated/client/client';
import { PrismaPg } from '@prisma/adapter-pg';

const sslCertPath = process.env.DB_SSL_CERT_PATH;

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL,
  ssl: sslCertPath
    ? {
        ca: fs.readFileSync(sslCertPath, 'utf-8'),
        rejectUnauthorized: false,
      }
    : undefined,
});

const prisma = new PrismaClient({ adapter });

export default prisma;
