/*
  Warnings:

  - You are about to drop the column `stock_id` on the `DPRMaterialConsumption` table. All the data in the column will be lost.
  - You are about to drop the column `unit` on the `DPRMaterialConsumption` table. All the data in the column will be lost.
  - You are about to drop the column `buyerId` on the `Invoice` table. All the data in the column will be lost.
  - You are about to drop the column `eInvoiceDetailId` on the `Invoice` table. All the data in the column will be lost.
  - You are about to drop the column `orderReferenceId` on the `Invoice` table. All the data in the column will be lost.
  - You are about to drop the column `placeOfSupply` on the `Invoice` table. All the data in the column will be lost.
  - You are about to alter the column `goodsValue` on the `InvoiceAmountSummary` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `taxableValue` on the `InvoiceAmountSummary` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `freightAmount` on the `InvoiceAmountSummary` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `unloadingAmount` on the `InvoiceAmountSummary` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `roundOff` on the `InvoiceAmountSummary` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `totalTaxAmount` on the `InvoiceAmountSummary` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `totalInvoiceValue` on the `InvoiceAmountSummary` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to drop the column `category` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to drop the column `grade` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to drop the column `hsnCode` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to drop the column `identificationMark` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to drop the column `quantity` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to drop the column `ratePerUnit` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to drop the column `unitOfMeasure` on the `InvoiceItem` table. All the data in the column will be lost.
  - You are about to alter the column `basicAmount` on the `InvoiceItem` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `freightRatePerUnit` on the `InvoiceItem` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `unloadingRatePerUnit` on the `InvoiceItem` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `taxableValue` on the `InvoiceItem` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `cgstRate` on the `TaxDetail` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `cgstAmount` on the `TaxDetail` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `sgstRate` on the `TaxDetail` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `sgstAmount` on the `TaxDetail` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `igstRate` on the `TaxDetail` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `igstAmount` on the `TaxDetail` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to alter the column `totalTax` on the `TaxDetail` table. The data in that column could be lost. The data in that column will be cast from `Decimal(65,30)` to `DoublePrecision`.
  - You are about to drop the `Buyer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Consignee` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `EInvoiceDetail` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `OrderReference` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Seller` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[invoiceId]` on the table `InvoiceAmountSummary` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[invoiceId]` on the table `InvoiceAudit` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[invoiceId]` on the table `TaxDetail` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[invoiceId]` on the table `TransportDetail` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `material_id` to the `DPRMaterialConsumption` table without a default value. This is not possible if the table is not empty.
  - Added the required column `location_id` to the `Invoice` table without a default value. This is not possible if the table is not empty.
  - Added the required column `po_id` to the `Invoice` table without a default value. This is not possible if the table is not empty.
  - Added the required column `grn_id` to the `InvoiceItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `grn_material_receipt_id` to the `InvoiceItem` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "DPRMaterialConsumption" DROP CONSTRAINT "DPRMaterialConsumption_stock_id_fkey";

-- DropForeignKey
ALTER TABLE "EInvoiceDetail" DROP CONSTRAINT "EInvoiceDetail_invoiceId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_buyerId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_consigneeId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_invoiceAmountSummaryId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_invoiceAuditId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_orderReferenceId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_sellerId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_taxDetailId_fkey";

-- DropForeignKey
ALTER TABLE "Invoice" DROP CONSTRAINT "Invoice_transportDetailId_fkey";

-- DropIndex
DROP INDEX "Invoice_invoiceAmountSummaryId_key";

-- DropIndex
DROP INDEX "Invoice_invoiceAuditId_key";

-- DropIndex
DROP INDEX "Invoice_orderReferenceId_key";

-- DropIndex
DROP INDEX "Invoice_taxDetailId_key";

-- DropIndex
DROP INDEX "Invoice_transportDetailId_key";

-- AlterTable
ALTER TABLE "DPRMaterialConsumption" DROP COLUMN "stock_id",
DROP COLUMN "unit",
ADD COLUMN     "material_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Invoice" DROP COLUMN "buyerId",
DROP COLUMN "eInvoiceDetailId",
DROP COLUMN "orderReferenceId",
DROP COLUMN "placeOfSupply",
ADD COLUMN     "buyer" TEXT,
ADD COLUMN     "location_id" INTEGER NOT NULL,
ADD COLUMN     "po_id" INTEGER NOT NULL,
ADD COLUMN     "userId" INTEGER;

-- AlterTable
ALTER TABLE "InvoiceAmountSummary" ADD COLUMN     "invoiceId" INTEGER,
ALTER COLUMN "goodsValue" DROP NOT NULL,
ALTER COLUMN "goodsValue" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "taxableValue" DROP NOT NULL,
ALTER COLUMN "taxableValue" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "freightAmount" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "unloadingAmount" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "roundOff" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "totalTaxAmount" DROP NOT NULL,
ALTER COLUMN "totalTaxAmount" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "totalInvoiceValue" DROP NOT NULL,
ALTER COLUMN "totalInvoiceValue" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "InvoiceAudit" ADD COLUMN     "invoiceId" INTEGER;

-- AlterTable
ALTER TABLE "InvoiceItem" DROP COLUMN "category",
DROP COLUMN "description",
DROP COLUMN "grade",
DROP COLUMN "hsnCode",
DROP COLUMN "identificationMark",
DROP COLUMN "quantity",
DROP COLUMN "ratePerUnit",
DROP COLUMN "unitOfMeasure",
ADD COLUMN     "grn_id" INTEGER NOT NULL,
ADD COLUMN     "grn_material_receipt_id" INTEGER NOT NULL,
ALTER COLUMN "basicAmount" DROP NOT NULL,
ALTER COLUMN "basicAmount" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "freightRatePerUnit" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "unloadingRatePerUnit" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "taxableValue" DROP NOT NULL,
ALTER COLUMN "taxableValue" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "TaxDetail" ADD COLUMN     "invoiceId" INTEGER,
ALTER COLUMN "cgstRate" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "cgstAmount" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "sgstRate" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "sgstAmount" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "igstRate" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "igstAmount" SET DATA TYPE DOUBLE PRECISION,
ALTER COLUMN "totalTax" DROP NOT NULL,
ALTER COLUMN "totalTax" SET DATA TYPE DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "TransportDetail" ADD COLUMN     "invoiceId" INTEGER;

-- DropTable
DROP TABLE "Buyer";

-- DropTable
DROP TABLE "Consignee";

-- DropTable
DROP TABLE "EInvoiceDetail";

-- DropTable
DROP TABLE "OrderReference";

-- DropTable
DROP TABLE "Seller";

-- CreateIndex
CREATE UNIQUE INDEX "InvoiceAmountSummary_invoiceId_key" ON "InvoiceAmountSummary"("invoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "InvoiceAudit_invoiceId_key" ON "InvoiceAudit"("invoiceId");

-- CreateIndex
CREATE INDEX "InvoiceItem_grn_id_idx" ON "InvoiceItem"("grn_id");

-- CreateIndex
CREATE UNIQUE INDEX "TaxDetail_invoiceId_key" ON "TaxDetail"("invoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "TransportDetail_invoiceId_key" ON "TransportDetail"("invoiceId");

-- AddForeignKey
ALTER TABLE "DPRMaterialConsumption" ADD CONSTRAINT "DPRMaterialConsumption_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "PO"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "Vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_consigneeId_fkey" FOREIGN KEY ("consigneeId") REFERENCES "Vendor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "Location"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvoiceItem" ADD CONSTRAINT "InvoiceItem_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "GRN"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvoiceItem" ADD CONSTRAINT "InvoiceItem_grn_material_receipt_id_fkey" FOREIGN KEY ("grn_material_receipt_id") REFERENCES "GRNMaterialReceipt"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TaxDetail" ADD CONSTRAINT "TaxDetail_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvoiceAmountSummary" ADD CONSTRAINT "InvoiceAmountSummary_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TransportDetail" ADD CONSTRAINT "TransportDetail_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvoiceAudit" ADD CONSTRAINT "InvoiceAudit_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;
