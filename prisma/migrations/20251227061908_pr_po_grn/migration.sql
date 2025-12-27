/*
  Warnings:

  - Changed the type of `material_id` on the `GRNMaterialReceipt` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `project_id` on the `PO` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `vendor_id` on the `PO` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `material_id` on the `POOrderItem` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `project_id` on the `PR` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `material_id` on the `PRMaterialItem` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "GRNMaterialReceipt" DROP COLUMN "material_id",
ADD COLUMN     "material_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "PO" DROP COLUMN "project_id",
ADD COLUMN     "project_id" INTEGER NOT NULL,
DROP COLUMN "vendor_id",
ADD COLUMN     "vendor_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "POOrderItem" DROP COLUMN "material_id",
ADD COLUMN     "material_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "PR" DROP COLUMN "project_id",
ADD COLUMN     "project_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "PRMaterialItem" DROP COLUMN "material_id",
ADD COLUMN     "material_id" INTEGER NOT NULL;

-- CreateIndex
CREATE INDEX "PO_project_id_idx" ON "PO"("project_id");

-- CreateIndex
CREATE INDEX "PO_vendor_id_idx" ON "PO"("vendor_id");

-- CreateIndex
CREATE INDEX "PR_project_id_idx" ON "PR"("project_id");

-- AddForeignKey
ALTER TABLE "GRN" ADD CONSTRAINT "GRN_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "PO"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GRNMaterialReceipt" ADD CONSTRAINT "GRNMaterialReceipt_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PO" ADD CONSTRAINT "PO_pr_id_fkey" FOREIGN KEY ("pr_id") REFERENCES "PR"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PO" ADD CONSTRAINT "PO_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PO" ADD CONSTRAINT "PO_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "POOrderItem" ADD CONSTRAINT "POOrderItem_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PR" ADD CONSTRAINT "PR_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRMaterialItem" ADD CONSTRAINT "PRMaterialItem_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
