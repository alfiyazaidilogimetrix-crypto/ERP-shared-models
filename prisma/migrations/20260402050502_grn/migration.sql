-- AlterTable
ALTER TABLE "grn" ADD COLUMN     "grn_number" TEXT,
ADD COLUMN     "total_amount" INTEGER,
ADD COLUMN     "total_qty" INTEGER,
ADD COLUMN     "total_received" INTEGER,
ADD COLUMN     "total_rejected" INTEGER;

-- AlterTable
ALTER TABLE "invoice_tax" ADD COLUMN     "igst_amount" DOUBLE PRECISION,
ADD COLUMN     "igst_rate" DOUBLE PRECISION;
