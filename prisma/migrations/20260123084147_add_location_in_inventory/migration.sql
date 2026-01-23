/*
  Warnings:

  - Added the required column `location_id` to the `InventoryManager` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "InventoryManager" ADD COLUMN     "location_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "InventoryManager" ADD CONSTRAINT "InventoryManager_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
