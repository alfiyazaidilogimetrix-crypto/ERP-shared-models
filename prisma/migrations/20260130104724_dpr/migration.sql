-- AlterTable
ALTER TABLE "DPR" ADD COLUMN     "Dimension" TEXT;

-- AlterTable
ALTER TABLE "DPRMaterialConsumption" ALTER COLUMN "rate" DROP NOT NULL;
