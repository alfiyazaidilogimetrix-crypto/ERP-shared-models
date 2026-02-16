/*
  Warnings:

  - You are about to drop the column `activity_id` on the `scopes` table. All the data in the column will be lost.
  - You are about to drop the column `length` on the `scopes` table. All the data in the column will be lost.
  - You are about to drop the column `quantity` on the `scopes` table. All the data in the column will be lost.
  - You are about to drop the column `unit_id` on the `scopes` table. All the data in the column will be lost.
  - Added the required column `category_type` to the `materials` table without a default value. This is not possible if the table is not empty.
  - Added the required column `project_id` to the `scopes` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "scopes" DROP CONSTRAINT "scopes_activity_id_fkey";

-- DropForeignKey
ALTER TABLE "scopes" DROP CONSTRAINT "scopes_unit_id_fkey";

-- AlterTable
ALTER TABLE "materials" ADD COLUMN     "category_type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "scopes" DROP COLUMN "activity_id",
DROP COLUMN "length",
DROP COLUMN "quantity",
DROP COLUMN "unit_id",
ADD COLUMN     "project_id" INTEGER NOT NULL;

-- CreateTable
CREATE TABLE "project_file" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,

    CONSTRAINT "project_file_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project_scopes" (
    "id" SERIAL NOT NULL,
    "scope_id" INTEGER NOT NULL,
    "category_type" TEXT NOT NULL,
    "activity_id" INTEGER NOT NULL,
    "length" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "project_scopes_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "project_file" ADD CONSTRAINT "project_file_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_file" ADD CONSTRAINT "project_file_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scopes" ADD CONSTRAINT "scopes_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_scopes" ADD CONSTRAINT "project_scopes_scope_id_fkey" FOREIGN KEY ("scope_id") REFERENCES "scopes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_scopes" ADD CONSTRAINT "project_scopes_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_scopes" ADD CONSTRAINT "project_scopes_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
