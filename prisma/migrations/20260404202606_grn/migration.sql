/*
  Warnings:

  - You are about to drop the column `address` on the `grn` table. All the data in the column will be lost.
  - You are about to drop the column `district` on the `grn` table. All the data in the column will be lost.
  - You are about to drop the column `pincode` on the `grn` table. All the data in the column will be lost.
  - You are about to drop the column `state` on the `grn` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "grn" DROP COLUMN "address",
DROP COLUMN "district",
DROP COLUMN "pincode",
DROP COLUMN "state";
