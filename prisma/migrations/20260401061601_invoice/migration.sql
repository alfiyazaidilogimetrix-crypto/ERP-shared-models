/*
  Warnings:

  - You are about to drop the column `accepted` on the `grn_matrial_receipt` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "workscope_item" DROP CONSTRAINT "workscope_item_material_id_fkey";

-- AlterTable
ALTER TABLE "grn_matrial_receipt" DROP COLUMN "accepted",
ADD COLUMN     "amount" INTEGER,
ADD COLUMN     "hsn_no" TEXT,
ADD COLUMN     "quantity" INTEGER,
ADD COLUMN     "rate" INTEGER;

-- AlterTable
ALTER TABLE "workscope_item" ALTER COLUMN "material_id" DROP NOT NULL;

-- CreateTable
CREATE TABLE "invoices" (
    "id" SERIAL NOT NULL,
    "invoice_number" TEXT NOT NULL,
    "invoice_date" TIMESTAMP(3) NOT NULL,
    "invoice_type" TEXT NOT NULL,
    "irn" TEXT,
    "ack_no" TEXT,
    "ack_date" TIMESTAMP(3),
    "eway_bill_no" TEXT,
    "place_of_supply" TEXT,
    "destination" TEXT,
    "vehicle_number" TEXT,
    "total_quantity" DOUBLE PRECISION,
    "total_amount" DOUBLE PRECISION,
    "round_off" DOUBLE PRECISION,
    "amount_in_words" TEXT,
    "grn_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "invoices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_seller" (
    "id" SERIAL NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "godown_address" TEXT,
    "phone" TEXT[],
    "email" TEXT,
    "gstin" TEXT,
    "state" TEXT,
    "state_code" TEXT,
    "udyog_aadhar" TEXT,
    "pan" TEXT,

    CONSTRAINT "invoice_seller_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_buyer" (
    "id" SERIAL NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT,
    "gstin" TEXT,
    "state" TEXT,
    "state_code" TEXT,

    CONSTRAINT "invoice_buyer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_consignee" (
    "id" SERIAL NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT,
    "gstin" TEXT,
    "state" TEXT,
    "state_code" TEXT,

    CONSTRAINT "invoice_consignee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_tax" (
    "id" SERIAL NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "taxable_amount" DOUBLE PRECISION,
    "cgst_rate" DOUBLE PRECISION,
    "cgst_amount" DOUBLE PRECISION,
    "sgst_rate" DOUBLE PRECISION,
    "sgst_amount" DOUBLE PRECISION,
    "total_tax" DOUBLE PRECISION,
    "tax_in_words" TEXT,

    CONSTRAINT "invoice_tax_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_bank_details" (
    "id" SERIAL NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "account_holder_name" TEXT,
    "bank_name" TEXT,
    "account_number" TEXT,
    "ifsc_code" TEXT,
    "branch" TEXT,

    CONSTRAINT "invoice_bank_details_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "invoice_seller_invoice_id_key" ON "invoice_seller"("invoice_id");

-- CreateIndex
CREATE UNIQUE INDEX "invoice_buyer_invoice_id_key" ON "invoice_buyer"("invoice_id");

-- CreateIndex
CREATE UNIQUE INDEX "invoice_consignee_invoice_id_key" ON "invoice_consignee"("invoice_id");

-- CreateIndex
CREATE UNIQUE INDEX "invoice_tax_invoice_id_key" ON "invoice_tax"("invoice_id");

-- CreateIndex
CREATE UNIQUE INDEX "invoice_bank_details_invoice_id_key" ON "invoice_bank_details"("invoice_id");

-- AddForeignKey
ALTER TABLE "invoices" ADD CONSTRAINT "invoices_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "grn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_seller" ADD CONSTRAINT "invoice_seller_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "invoices"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_buyer" ADD CONSTRAINT "invoice_buyer_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "invoices"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_consignee" ADD CONSTRAINT "invoice_consignee_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "invoices"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_tax" ADD CONSTRAINT "invoice_tax_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "invoices"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_bank_details" ADD CONSTRAINT "invoice_bank_details_invoice_id_fkey" FOREIGN KEY ("invoice_id") REFERENCES "invoices"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workscope_item" ADD CONSTRAINT "workscope_item_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE SET NULL ON UPDATE CASCADE;
