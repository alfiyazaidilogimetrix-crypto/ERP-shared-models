-- CreateEnum
CREATE TYPE "DieselInwardStatus" AS ENUM ('PENDING', 'RECEIVED', 'CANCELLED');

-- AlterTable
ALTER TABLE "diesel_inward" ADD COLUMN     "status" "DieselInwardStatus" NOT NULL DEFAULT 'PENDING';
