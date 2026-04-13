/*
  Warnings:

  - Added the required column `branch_office_id` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `company_id` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `head_office_id` to the `project` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "project" ADD COLUMN     "branch_office_id" INTEGER NOT NULL,
ADD COLUMN     "company_id" INTEGER NOT NULL,
ADD COLUMN     "head_office_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "diesel_inward_file" (
    "id" SERIAL NOT NULL,
    "diesel_inward_id" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,

    CONSTRAINT "diesel_inward_file_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "diesel_inward_file" ADD CONSTRAINT "diesel_inward_file_diesel_inward_id_fkey" FOREIGN KEY ("diesel_inward_id") REFERENCES "diesel_inward"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_inward_file" ADD CONSTRAINT "diesel_inward_file_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "companies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_head_office_id_fkey" FOREIGN KEY ("head_office_id") REFERENCES "head_office"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_branch_office_id_fkey" FOREIGN KEY ("branch_office_id") REFERENCES "branch_office"("id") ON DELETE CASCADE ON UPDATE CASCADE;
