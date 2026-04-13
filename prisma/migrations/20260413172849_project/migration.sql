/*
  Warnings:

  - You are about to drop the column `other_details` on the `project` table. All the data in the column will be lost.
  - You are about to drop the column `urgency_level` on the `prs` table. All the data in the column will be lost.
  - You are about to drop the `bot_specific_details` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `epc_specific_details` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ham_specific_details` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "bot_specific_details" DROP CONSTRAINT "bot_specific_details_project_id_fkey";

-- DropForeignKey
ALTER TABLE "epc_specific_details" DROP CONSTRAINT "epc_specific_details_project_id_fkey";

-- DropForeignKey
ALTER TABLE "ham_specific_details" DROP CONSTRAINT "ham_specific_details_project_id_fkey";

-- AlterTable
ALTER TABLE "project" DROP COLUMN "other_details";

-- AlterTable
ALTER TABLE "prs" DROP COLUMN "urgency_level";

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "company_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "vendor" ADD COLUMN     "branch_office_id" INTEGER,
ADD COLUMN     "company_id" INTEGER,
ADD COLUMN     "head_office_id" INTEGER;

-- DropTable
DROP TABLE "bot_specific_details";

-- DropTable
DROP TABLE "epc_specific_details";

-- DropTable
DROP TABLE "ham_specific_details";

-- DropEnum
DROP TYPE "UrgencyLevel";

-- AddForeignKey
ALTER TABLE "vendor" ADD CONSTRAINT "vendor_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor" ADD CONSTRAINT "vendor_head_office_id_fkey" FOREIGN KEY ("head_office_id") REFERENCES "head_office"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor" ADD CONSTRAINT "vendor_branch_office_id_fkey" FOREIGN KEY ("branch_office_id") REFERENCES "branch_office"("id") ON DELETE CASCADE ON UPDATE CASCADE;
