// import { PrismaClient } from '../generated/client/client';
// import { PrismaPg } from '@prisma/adapter-pg';

// const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
// const prisma = new PrismaClient({ adapter });

// export default prisma;

import * as fs from 'fs';
import * as path from 'path';
import { PrismaClient } from '../generated/client/client';
import { PrismaPg } from '@prisma/adapter-pg';

const sslCertPath = process.env.DB_SSL_CERT_PATH;

const adapter = new PrismaPg({
  connectionString: process.env.DATABASE_URL,
  ssl: sslCertPath
    ? {
        ca: fs.readFileSync(path.resolve(sslCertPath), 'utf-8'),
        // 'rejectUnauthorized: false' is often needed for self-signed certs or if the CA isn't directly trusted by the runtime
        rejectUnauthorized: false,
      }
    : {
        rejectUnauthorized: false,
      },
});

const prisma = new PrismaClient({ adapter });

export default prisma;
