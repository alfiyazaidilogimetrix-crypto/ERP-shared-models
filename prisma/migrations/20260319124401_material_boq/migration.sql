-- DropForeignKey
ALTER TABLE "material_boq_item" DROP CONSTRAINT "material_boq_item_category_id_fkey";

-- DropForeignKey
ALTER TABLE "material_boq_item" DROP CONSTRAINT "material_boq_item_material_id_fkey";

-- AlterTable
ALTER TABLE "material_boq_item" ADD COLUMN     "item_description" TEXT,
ALTER COLUMN "material_id" DROP NOT NULL,
ALTER COLUMN "category_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "material_boq_item" ADD CONSTRAINT "material_boq_item_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_boq_item" ADD CONSTRAINT "material_boq_item_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE SET NULL ON UPDATE CASCADE;
