/*
  Warnings:

  - You are about to drop the column `current_stock` on the `materials` table. All the data in the column will be lost.
  - You are about to drop the column `opening_stock` on the `materials` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "materials" DROP COLUMN "current_stock",
DROP COLUMN "opening_stock";

-- CreateTable
CREATE TABLE "Stock" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "material_code" TEXT,
    "categoryId" INTEGER,
    "unitId" INTEGER,
    "status" TEXT NOT NULL DEFAULT 'in_stock',
    "minimum_threshold_quantity" INTEGER,
    "unit_of_measure" TEXT,
    "current_stock" INTEGER,
    "quantity" INTEGER,
    "specifications" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Stock_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Stock_material_code_key" ON "Stock"("material_code");
