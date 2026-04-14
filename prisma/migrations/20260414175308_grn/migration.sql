/*
  Warnings:

  - You are about to drop the column `store_location` on the `grn` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "grn" DROP COLUMN "store_location",
ADD COLUMN     "warehouse_id" INTEGER;

-- AddForeignKey
ALTER TABLE "grn" ADD CONSTRAINT "grn_warehouse_id_fkey" FOREIGN KEY ("warehouse_id") REFERENCES "warehouses"("id") ON DELETE CASCADE ON UPDATE CASCADE;
