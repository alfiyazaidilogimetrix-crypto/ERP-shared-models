/*
  Warnings:

  - You are about to drop the column `locationId` on the `stock` table. All the data in the column will be lost.
  - Added the required column `district` to the `inventory_manager` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pincode` to the `inventory_manager` table without a default value. This is not possible if the table is not empty.
  - Added the required column `state` to the `inventory_manager` table without a default value. This is not possible if the table is not empty.
  - Added the required column `District` to the `stock` table without a default value. This is not possible if the table is not empty.
  - Added the required column `State` to the `stock` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pincode` to the `stock` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "inventory_manager" ADD COLUMN     "district" TEXT NOT NULL,
ADD COLUMN     "pincode" TEXT NOT NULL,
ADD COLUMN     "state" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "stock" DROP COLUMN "locationId",
ADD COLUMN     "District" TEXT NOT NULL,
ADD COLUMN     "State" TEXT NOT NULL,
ADD COLUMN     "pincode" TEXT NOT NULL;
