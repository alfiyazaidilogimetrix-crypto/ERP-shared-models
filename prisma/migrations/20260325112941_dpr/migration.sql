-- AlterEnum
ALTER TYPE "Site_type" ADD VALUE 'NONE';

-- AlterTable
ALTER TABLE "dpr_chainages" ALTER COLUMN "site" SET DEFAULT 'NONE';
