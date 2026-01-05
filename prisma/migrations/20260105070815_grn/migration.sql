/*
  Warnings:

  - You are about to drop the column `status` on the `GRNMaterialReceipt` table. All the data in the column will be lost.
  - Added the required column `status` to the `GRN` table without a default value. This is not possible if the table is not empty.
  - Added the required column `Rejected` to the `GRNMaterialReceipt` table without a default value. This is not possible if the table is not empty.
  - Added the required column `accepted` to the `GRNMaterialReceipt` table without a default value. This is not possible if the table is not empty.
  - Added the required column `received` to the `GRNMaterialReceipt` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `ordered` on the `GRNMaterialReceipt` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ReceiptStatus" ADD VALUE 'PARTIALLY_ACCEPTED';
ALTER TYPE "ReceiptStatus" ADD VALUE 'PENDING';

-- AlterTable
ALTER TABLE "GRN" ADD COLUMN     "status" "ReceiptStatus" NOT NULL;

-- AlterTable
ALTER TABLE "GRNMaterialReceipt" DROP COLUMN "status",
ADD COLUMN     "Rejected" INTEGER NOT NULL,
ADD COLUMN     "accepted" INTEGER NOT NULL,
ADD COLUMN     "received" INTEGER NOT NULL,
DROP COLUMN "ordered",
ADD COLUMN     "ordered" INTEGER NOT NULL;
