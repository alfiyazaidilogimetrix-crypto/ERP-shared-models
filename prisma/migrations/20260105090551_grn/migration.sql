/*
  Warnings:

  - You are about to drop the column `Rejected` on the `GRNMaterialReceipt` table. All the data in the column will be lost.
  - Added the required column `rejected` to the `GRNMaterialReceipt` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "GRNMaterialReceipt" DROP COLUMN "Rejected",
ADD COLUMN     "rejected" INTEGER NOT NULL;
