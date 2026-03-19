/*
  Warnings:

  - You are about to drop the `contractor_files` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `contractor_projects` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "work_order_status" AS ENUM ('PENDING', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "payment_status" AS ENUM ('PENDING', 'PAID', 'PARTIALLY_PAID');

-- DropForeignKey
ALTER TABLE "contractor_files" DROP CONSTRAINT "contractor_files_contractorProjectId_fkey";

-- DropForeignKey
ALTER TABLE "contractor_files" DROP CONSTRAINT "contractor_files_file_id_fkey";

-- DropForeignKey
ALTER TABLE "contractor_projects" DROP CONSTRAINT "contractor_projects_contractorId_fkey";

-- DropForeignKey
ALTER TABLE "contractor_projects" DROP CONSTRAINT "contractor_projects_projectId_fkey";

-- AlterTable
ALTER TABLE "pos" ADD COLUMN     "gst_amount" TEXT,
ADD COLUMN     "gst_percent" TEXT;

-- DropTable
DROP TABLE "contractor_files";

-- DropTable
DROP TABLE "contractor_projects";

-- CreateTable
CREATE TABLE "sub_contractor_work_order" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "vendor_id" INTEGER NOT NULL,
    "materia_boq_id" INTEGER NOT NULL,
    "work_order_no" TEXT NOT NULL,
    "work_order_date" TIMESTAMP(3) NOT NULL,
    "work_order_status" "work_order_status",
    "work_order_description" TEXT,
    "work_order_amount" TEXT,
    "payment_status" "payment_status" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sub_contractor_work_order_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "sub_contractor_work_order" ADD CONSTRAINT "sub_contractor_work_order_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sub_contractor_work_order" ADD CONSTRAINT "sub_contractor_work_order_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sub_contractor_work_order" ADD CONSTRAINT "sub_contractor_work_order_materia_boq_id_fkey" FOREIGN KEY ("materia_boq_id") REFERENCES "material_boq"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
