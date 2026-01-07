/*
  Warnings:

  - You are about to drop the column `chainage` on the `Chainage_consumption_ledger` table. All the data in the column will be lost.
  - You are about to drop the column `equipment` on the `Chainage_consumption_ledger` table. All the data in the column will be lost.
  - You are about to drop the column `labours` on the `Chainage_consumption_ledger` table. All the data in the column will be lost.
  - You are about to drop the column `materials` on the `Chainage_consumption_ledger` table. All the data in the column will be lost.
  - You are about to drop the column `sub_contractor` on the `Chainage_consumption_ledger` table. All the data in the column will be lost.
  - You are about to drop the column `total_cost` on the `Chainage_consumption_ledger` table. All the data in the column will be lost.
  - Added the required column `chainage_data` to the `Chainage_consumption_ledger` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Chainage_consumption_ledger" DROP COLUMN "chainage",
DROP COLUMN "equipment",
DROP COLUMN "labours",
DROP COLUMN "materials",
DROP COLUMN "sub_contractor",
DROP COLUMN "total_cost",
ADD COLUMN     "chainage_data" JSONB NOT NULL;
