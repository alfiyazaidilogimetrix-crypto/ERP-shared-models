-- AlterTable
ALTER TABLE "grn" ADD COLUMN     "address" TEXT,
ADD COLUMN     "district" TEXT,
ADD COLUMN     "pincode" TEXT,
ADD COLUMN     "state" TEXT;

-- AlterTable
ALTER TABLE "pr_grns" ADD COLUMN     "store_location" TEXT;
