/*
  Warnings:

  - You are about to drop the `inventory_history` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `inventory_manager` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `inventory_stock_entry` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `manager_id` to the `stock` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "inventory_history" DROP CONSTRAINT "inventory_history_manager_id_fkey";

-- DropForeignKey
ALTER TABLE "inventory_history" DROP CONSTRAINT "inventory_history_project_id_fkey";

-- DropForeignKey
ALTER TABLE "inventory_manager" DROP CONSTRAINT "inventory_manager_userId_fkey";

-- DropForeignKey
ALTER TABLE "inventory_stock_entry" DROP CONSTRAINT "inventory_stock_entry_inventoryId_fkey";

-- DropForeignKey
ALTER TABLE "inventory_stock_entry" DROP CONSTRAINT "inventory_stock_entry_stockId_fkey";

-- AlterTable
ALTER TABLE "stock" ADD COLUMN     "manager_id" INTEGER NOT NULL;

-- DropTable
DROP TABLE "inventory_history";

-- DropTable
DROP TABLE "inventory_manager";

-- DropTable
DROP TABLE "inventory_stock_entry";

-- AddForeignKey
ALTER TABLE "stock" ADD CONSTRAINT "stock_manager_id_fkey" FOREIGN KEY ("manager_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
