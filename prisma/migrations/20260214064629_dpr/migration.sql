/*
  Warnings:

  - You are about to drop the column `activity_id` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `category` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `chainage` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `depth` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `length` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `number` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `plan_quantity` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `quantity` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `site` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `sub_activity_id` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `unit_id` on the `dprs` table. All the data in the column will be lost.
  - You are about to drop the column `width` on the `dprs` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "dprs" DROP CONSTRAINT "dprs_activity_id_fkey";

-- DropForeignKey
ALTER TABLE "dprs" DROP CONSTRAINT "dprs_sub_activity_id_fkey";

-- DropForeignKey
ALTER TABLE "dprs" DROP CONSTRAINT "dprs_unit_id_fkey";

-- AlterTable
ALTER TABLE "dprs" DROP COLUMN "activity_id",
DROP COLUMN "category",
DROP COLUMN "chainage",
DROP COLUMN "depth",
DROP COLUMN "length",
DROP COLUMN "number",
DROP COLUMN "plan_quantity",
DROP COLUMN "quantity",
DROP COLUMN "site",
DROP COLUMN "sub_activity_id",
DROP COLUMN "unit_id",
DROP COLUMN "width";

-- CreateTable
CREATE TABLE "dpr_chainages" (
    "id" SERIAL NOT NULL,
    "dpr_id" INTEGER NOT NULL,
    "site" "Site_type" NOT NULL,
    "chainage" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "activity_id" INTEGER NOT NULL,
    "sub_activity_id" INTEGER NOT NULL,
    "number" INTEGER NOT NULL,
    "length" INTEGER NOT NULL,
    "width" INTEGER NOT NULL,
    "depth" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "plan_quantity" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dpr_chainages_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "dpr_chainages_dpr_id_idx" ON "dpr_chainages"("dpr_id");

-- AddForeignKey
ALTER TABLE "dpr_chainages" ADD CONSTRAINT "dpr_chainages_dpr_id_fkey" FOREIGN KEY ("dpr_id") REFERENCES "dprs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dpr_chainages" ADD CONSTRAINT "dpr_chainages_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dpr_chainages" ADD CONSTRAINT "dpr_chainages_sub_activity_id_fkey" FOREIGN KEY ("sub_activity_id") REFERENCES "materials"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dpr_chainages" ADD CONSTRAINT "dpr_chainages_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE CASCADE ON UPDATE CASCADE;
