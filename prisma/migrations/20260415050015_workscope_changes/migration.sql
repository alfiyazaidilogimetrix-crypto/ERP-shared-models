/*
  Warnings:

  - You are about to drop the column `balanced` on the `workscope_item` table. All the data in the column will be lost.
  - You are about to drop the column `executed` on the `workscope_item` table. All the data in the column will be lost.
  - You are about to drop the column `length` on the `workscope_item` table. All the data in the column will be lost.
  - You are about to drop the column `material_id` on the `workscope_item` table. All the data in the column will be lost.
  - You are about to drop the column `unit_id` on the `workscope_item` table. All the data in the column will be lost.
  - Added the required column `end_date` to the `workscope_item` table without a default value. This is not possible if the table is not empty.
  - Added the required column `start_date` to the `workscope_item` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "WorkScopeStatus" AS ENUM ('PENDING', 'CONFIGURED', 'IN_PROGRESS', 'COMPLETED', 'ON_HOLD');

-- DropForeignKey
ALTER TABLE "workscope_item" DROP CONSTRAINT "workscope_item_material_id_fkey";

-- DropForeignKey
ALTER TABLE "workscope_item" DROP CONSTRAINT "workscope_item_unit_id_fkey";

-- DropForeignKey
ALTER TABLE "workscope_item" DROP CONSTRAINT "workscope_item_workscope_id_fkey";

-- AlterTable
ALTER TABLE "workscope_item" DROP COLUMN "balanced",
DROP COLUMN "executed",
DROP COLUMN "length",
DROP COLUMN "material_id",
DROP COLUMN "unit_id",
ADD COLUMN     "end_date" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "start_date" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "status" "WorkScopeStatus" NOT NULL DEFAULT 'PENDING';

-- CreateTable
CREATE TABLE "material_consumption" (
    "id" SERIAL NOT NULL,
    "workscope_item_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "quantity" DOUBLE PRECISION,
    "unit_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "material_consumption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "labour_allocation" (
    "id" SERIAL NOT NULL,
    "workscope_item_id" INTEGER NOT NULL,
    "labour_type" TEXT,
    "count" INTEGER,
    "days" INTEGER,
    "rate_per_day" DOUBLE PRECISION,
    "total_cost" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "labour_allocation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "machinery_allocation" (
    "id" SERIAL NOT NULL,
    "workscope_item_id" INTEGER NOT NULL,
    "machine_id" INTEGER NOT NULL,
    "count" INTEGER,
    "hours" DOUBLE PRECISION,
    "rate_per_hour" DOUBLE PRECISION,
    "total_cost" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "machinery_allocation_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "workscope_item" ADD CONSTRAINT "workscope_item_workscope_id_fkey" FOREIGN KEY ("workscope_id") REFERENCES "workscope"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_consumption" ADD CONSTRAINT "material_consumption_workscope_item_id_fkey" FOREIGN KEY ("workscope_item_id") REFERENCES "workscope_item"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_consumption" ADD CONSTRAINT "material_consumption_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_consumption" ADD CONSTRAINT "material_consumption_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "labour_allocation" ADD CONSTRAINT "labour_allocation_workscope_item_id_fkey" FOREIGN KEY ("workscope_item_id") REFERENCES "workscope_item"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "machinery_allocation" ADD CONSTRAINT "machinery_allocation_workscope_item_id_fkey" FOREIGN KEY ("workscope_item_id") REFERENCES "workscope_item"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "machinery_allocation" ADD CONSTRAINT "machinery_allocation_machine_id_fkey" FOREIGN KEY ("machine_id") REFERENCES "machines"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
