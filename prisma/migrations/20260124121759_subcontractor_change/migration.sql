/*
  Warnings:

  - You are about to drop the `sub_contractors` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "contractor_projects" DROP CONSTRAINT "contractor_projects_contractorId_fkey";

-- AlterTable
ALTER TABLE "contractor_projects" ADD COLUMN     "end_date" TIMESTAMP(3),
ADD COLUMN     "overall_budget" TEXT,
ADD COLUMN     "partnership_percentage" TEXT,
ADD COLUMN     "start_date" TIMESTAMP(3);

-- DropTable
DROP TABLE "sub_contractors";

-- CreateTable
CREATE TABLE "ContractorFiles" (
    "id" SERIAL NOT NULL,
    "contactProjectId" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,
    "report_type" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "ContractorFiles_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "contractor_projects" ADD CONSTRAINT "contractor_projects_contractorId_fkey" FOREIGN KEY ("contractorId") REFERENCES "Vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContractorFiles" ADD CONSTRAINT "ContractorFiles_contactProjectId_fkey" FOREIGN KEY ("contactProjectId") REFERENCES "contractor_projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContractorFiles" ADD CONSTRAINT "ContractorFiles_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "File"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
