/*
  Warnings:

  - You are about to drop the column `contactProjectId` on the `ContractorFiles` table. All the data in the column will be lost.
  - Added the required column `contractorProjectId` to the `ContractorFiles` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "ContractorFiles" DROP CONSTRAINT "ContractorFiles_contactProjectId_fkey";

-- AlterTable
ALTER TABLE "ContractorFiles" DROP COLUMN "contactProjectId",
ADD COLUMN     "contractorProjectId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "ContractorFiles" ADD CONSTRAINT "ContractorFiles_contractorProjectId_fkey" FOREIGN KEY ("contractorProjectId") REFERENCES "contractor_projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
