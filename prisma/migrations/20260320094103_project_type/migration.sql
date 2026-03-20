/*
  Warnings:

  - You are about to drop the column `project_type` on the `project` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "dpr_chainages" ADD COLUMN     "amount" INTEGER,
ADD COLUMN     "boq_rate" INTEGER,
ADD COLUMN     "work_description" TEXT,
ALTER COLUMN "site" DROP NOT NULL,
ALTER COLUMN "chainage_from" DROP NOT NULL,
ALTER COLUMN "chainge_to" DROP NOT NULL,
ALTER COLUMN "number" DROP NOT NULL,
ALTER COLUMN "length" DROP NOT NULL,
ALTER COLUMN "width" DROP NOT NULL,
ALTER COLUMN "depth" DROP NOT NULL,
ALTER COLUMN "quantity" DROP NOT NULL,
ALTER COLUMN "plan_quantity" DROP NOT NULL;

-- AlterTable
ALTER TABLE "po_order_items" ADD COLUMN     "hsn_no" TEXT;

-- AlterTable
ALTER TABLE "project" DROP COLUMN "project_type",
ADD COLUMN     "project_type_id" INTEGER;

-- AlterTable
ALTER TABLE "sub_contractor_work_order" ADD COLUMN     "meta_data" JSONB;

-- DropEnum
DROP TYPE "ProjectType";

-- CreateTable
CREATE TABLE "project_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "project_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "work_order_items" (
    "id" SERIAL NOT NULL,
    "work_order_id" INTEGER NOT NULL,
    "material_boq_item_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "work_order_items_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_project_type_id_fkey" FOREIGN KEY ("project_type_id") REFERENCES "project_types"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_order_items" ADD CONSTRAINT "work_order_items_material_boq_item_id_fkey" FOREIGN KEY ("material_boq_item_id") REFERENCES "material_boq_item"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "work_order_items" ADD CONSTRAINT "work_order_items_work_order_id_fkey" FOREIGN KEY ("work_order_id") REFERENCES "sub_contractor_work_order"("id") ON DELETE CASCADE ON UPDATE CASCADE;
