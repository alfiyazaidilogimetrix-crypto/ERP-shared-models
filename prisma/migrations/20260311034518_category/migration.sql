/*
  Warnings:

  - You are about to drop the column `category_type` on the `activities` table. All the data in the column will be lost.
  - You are about to drop the column `category` on the `dpr_chainages` table. All the data in the column will be lost.
  - You are about to drop the column `category` on the `material_boq_item` table. All the data in the column will be lost.
  - You are about to drop the column `category_type` on the `materials` table. All the data in the column will be lost.
  - You are about to drop the column `category` on the `workscope_item` table. All the data in the column will be lost.
  - Added the required column `category_id` to the `activities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_id` to the `dpr_chainages` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_id` to the `material_boq_item` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_id` to the `workscope_item` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "activities" DROP COLUMN "category_type",
ADD COLUMN     "category_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "dpr_chainages" DROP COLUMN "category",
ADD COLUMN     "category_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "material_boq_item" DROP COLUMN "category",
ADD COLUMN     "category_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "materials" DROP COLUMN "category_type",
ADD COLUMN     "categoryId" INTEGER;

-- AlterTable
ALTER TABLE "workscope_item" DROP COLUMN "category",
ADD COLUMN     "category_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "dpr_chainages" ADD CONSTRAINT "dpr_chainages_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "activities" ADD CONSTRAINT "activities_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materials" ADD CONSTRAINT "materials_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_boq_item" ADD CONSTRAINT "material_boq_item_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workscope_item" ADD CONSTRAINT "workscope_item_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
