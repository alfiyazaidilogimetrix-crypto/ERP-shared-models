/*
  Warnings:

  - You are about to drop the column `categoryId` on the `Stock` table. All the data in the column will be lost.
  - You are about to drop the column `material_code` on the `Stock` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `Stock` table. All the data in the column will be lost.
  - You are about to drop the column `unitId` on the `Stock` table. All the data in the column will be lost.
  - You are about to drop the column `unit_of_measure` on the `Stock` table. All the data in the column will be lost.
  - Added the required column `material_id` to the `Stock` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Stock" DROP CONSTRAINT "Stock_categoryId_fkey";

-- DropForeignKey
ALTER TABLE "Stock" DROP CONSTRAINT "Stock_unitId_fkey";

-- DropIndex
DROP INDEX "Stock_material_code_key";

-- AlterTable
ALTER TABLE "Stock" DROP COLUMN "categoryId",
DROP COLUMN "material_code",
DROP COLUMN "name",
DROP COLUMN "unitId",
DROP COLUMN "unit_of_measure",
ADD COLUMN     "material_id" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
