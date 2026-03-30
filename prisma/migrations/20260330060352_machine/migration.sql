/*
  Warnings:

  - Added the required column `machine_count` to the `machines` table without a default value. This is not possible if the table is not empty.
  - Added the required column `project_id` to the `machines` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "machines" ADD COLUMN     "machine_count" INTEGER NOT NULL,
ADD COLUMN     "project_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "machines" ADD CONSTRAINT "machines_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
