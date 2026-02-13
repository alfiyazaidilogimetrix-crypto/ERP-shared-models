/*
  Warnings:

  - You are about to drop the column `District` on the `stock` table. All the data in the column will be lost.
  - You are about to drop the column `State` on the `stock` table. All the data in the column will be lost.
  - Added the required column `district` to the `stock` table without a default value. This is not possible if the table is not empty.
  - Added the required column `state` to the `stock` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "stock" DROP COLUMN "District",
DROP COLUMN "State",
ADD COLUMN     "district" TEXT NOT NULL,
ADD COLUMN     "state" TEXT NOT NULL;
