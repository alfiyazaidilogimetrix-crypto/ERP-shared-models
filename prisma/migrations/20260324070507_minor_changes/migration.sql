/*
  Warnings:

  - You are about to drop the `diesel_transactions` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `project_id` to the `diesel_consumption` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "diesel_transactions" DROP CONSTRAINT "diesel_transactions_project_id_fkey";

-- DropForeignKey
ALTER TABLE "diesel_transactions" DROP CONSTRAINT "diesel_transactions_vendor_id_fkey";

-- AlterTable
ALTER TABLE "diesel_consumption" ADD COLUMN     "project_id" INTEGER NOT NULL;

-- DropTable
DROP TABLE "diesel_transactions";

-- DropEnum
DROP TYPE "DieselTransactionType";

-- AddForeignKey
ALTER TABLE "diesel_consumption" ADD CONSTRAINT "diesel_consumption_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
