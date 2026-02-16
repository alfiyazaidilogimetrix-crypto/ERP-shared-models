/*
  Warnings:

  - You are about to drop the column `chainage` on the `dpr_chainages` table. All the data in the column will be lost.
  - You are about to drop the column `sub_activity_id` on the `dpr_chainages` table. All the data in the column will be lost.
  - Added the required column `chainage_from` to the `dpr_chainages` table without a default value. This is not possible if the table is not empty.
  - Added the required column `chainge_to` to the `dpr_chainages` table without a default value. This is not possible if the table is not empty.
  - Added the required column `material_id` to the `dpr_chainages` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "dpr_chainages" DROP CONSTRAINT "dpr_chainages_sub_activity_id_fkey";

-- DropForeignKey
ALTER TABLE "dpr_files" DROP CONSTRAINT "dpr_files_dpr_id_fkey";

-- AlterTable
ALTER TABLE "dpr_chainages" DROP COLUMN "chainage",
DROP COLUMN "sub_activity_id",
ADD COLUMN     "chainage_from" TEXT NOT NULL,
ADD COLUMN     "chainge_to" TEXT NOT NULL,
ADD COLUMN     "material_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "dpr_chainages" ADD CONSTRAINT "dpr_chainages_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dpr_files" ADD CONSTRAINT "dpr_files_dpr_id_fkey" FOREIGN KEY ("dpr_id") REFERENCES "dpr_chainages"("id") ON DELETE CASCADE ON UPDATE CASCADE;
