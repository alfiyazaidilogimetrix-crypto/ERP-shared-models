/*
  Warnings:

  - The `vendor_id` column on the `DieselTransaction` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `user_id` column on the `PR` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `approved_by` column on the `PR` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `project_id` on the `DPR` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `submitted_by` on the `DPR` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `material_id` on the `DPRMaterialConsumption` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `project_id` on the `DieselTransaction` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "DPR" DROP COLUMN "project_id",
ADD COLUMN     "project_id" INTEGER NOT NULL,
DROP COLUMN "submitted_by",
ADD COLUMN     "submitted_by" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "DPRMaterialConsumption" DROP COLUMN "material_id",
ADD COLUMN     "material_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "DieselTransaction" DROP COLUMN "project_id",
ADD COLUMN     "project_id" INTEGER NOT NULL,
DROP COLUMN "vendor_id",
ADD COLUMN     "vendor_id" INTEGER;

-- AlterTable
ALTER TABLE "PR" DROP COLUMN "user_id",
ADD COLUMN     "user_id" INTEGER,
DROP COLUMN "approved_by",
ADD COLUMN     "approved_by" INTEGER;

-- CreateTable
CREATE TABLE "Invoice" (
    "id" SERIAL NOT NULL,
    "invoiceNumber" TEXT NOT NULL,
    "invoiceDate" TIMESTAMP(3) NOT NULL,
    "invoiceType" TEXT NOT NULL,
    "placeOfSupply" TEXT NOT NULL,
    "reverseCharge" BOOLEAN NOT NULL DEFAULT false,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "sellerId" INTEGER NOT NULL,
    "buyerId" INTEGER NOT NULL,
    "consigneeId" INTEGER,
    "orderReferenceId" INTEGER,
    "taxDetailId" INTEGER,
    "amountSummaryId" INTEGER,
    "transportDetailId" INTEGER,
    "eInvoiceDetailId" INTEGER,
    "auditDetailId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "invoiceAmountSummaryId" INTEGER,
    "invoiceAuditId" INTEGER,

    CONSTRAINT "Invoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Seller" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "unitName" TEXT,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "stateCode" TEXT NOT NULL,
    "pincode" TEXT,
    "gstin" TEXT NOT NULL,
    "cin" TEXT,
    "pan" TEXT,
    "email" TEXT,
    "phone" TEXT,
    "website" TEXT,

    CONSTRAINT "Seller_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Buyer" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "stateCode" TEXT NOT NULL,
    "pincode" TEXT,
    "gstin" TEXT,
    "phone" TEXT,

    CONSTRAINT "Buyer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Consignee" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "stateCode" TEXT NOT NULL,
    "pincode" TEXT,
    "gstin" TEXT,
    "phone" TEXT,

    CONSTRAINT "Consignee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderReference" (
    "id" SERIAL NOT NULL,
    "purchaseOrderNo" TEXT,
    "purchaseOrderDate" TIMESTAMP(3),
    "salesOrderNo" TEXT,
    "deliveryOrderNo" TEXT,
    "challanNo" TEXT,
    "challanDate" TIMESTAMP(3),
    "contractNo" TEXT,

    CONSTRAINT "OrderReference_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvoiceItem" (
    "id" SERIAL NOT NULL,
    "invoiceId" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "hsnCode" TEXT NOT NULL,
    "grade" TEXT,
    "identificationMark" TEXT,
    "quantity" DECIMAL(65,30) NOT NULL,
    "unitOfMeasure" TEXT NOT NULL,
    "ratePerUnit" DECIMAL(65,30) NOT NULL,
    "basicAmount" DECIMAL(65,30) NOT NULL,
    "freightRatePerUnit" DECIMAL(65,30),
    "unloadingRatePerUnit" DECIMAL(65,30),
    "taxableValue" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "InvoiceItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TaxDetail" (
    "id" SERIAL NOT NULL,
    "cgstRate" DECIMAL(65,30),
    "cgstAmount" DECIMAL(65,30),
    "sgstRate" DECIMAL(65,30),
    "sgstAmount" DECIMAL(65,30),
    "igstRate" DECIMAL(65,30),
    "igstAmount" DECIMAL(65,30),
    "totalTax" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "TaxDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvoiceAmountSummary" (
    "id" SERIAL NOT NULL,
    "goodsValue" DECIMAL(65,30) NOT NULL,
    "taxableValue" DECIMAL(65,30) NOT NULL,
    "freightAmount" DECIMAL(65,30),
    "unloadingAmount" DECIMAL(65,30),
    "roundOff" DECIMAL(65,30),
    "totalTaxAmount" DECIMAL(65,30) NOT NULL,
    "totalInvoiceValue" DECIMAL(65,30) NOT NULL,
    "amountInWords" TEXT NOT NULL,

    CONSTRAINT "InvoiceAmountSummary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TransportDetail" (
    "id" SERIAL NOT NULL,
    "transporterName" TEXT NOT NULL,
    "transporterGstin" TEXT,
    "vehicleNumber" TEXT,
    "wagonNumber" TEXT,
    "transportMode" TEXT NOT NULL,
    "lrRrNo" TEXT,
    "lrRrDate" TIMESTAMP(3),
    "dispatchFrom" TEXT,
    "destination" TEXT,
    "distanceKm" INTEGER,

    CONSTRAINT "TransportDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EInvoiceDetail" (
    "id" SERIAL NOT NULL,
    "irnNumber" TEXT,
    "qrCode" TEXT,
    "ewayBillNo" TEXT,
    "ewayBillDate" TIMESTAMP(3),
    "ewayBillValidity" TIMESTAMP(3),
    "gstRuleReference" TEXT,
    "invoiceId" INTEGER,

    CONSTRAINT "EInvoiceDetail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InvoiceAudit" (
    "id" SERIAL NOT NULL,
    "preparedBy" TEXT,
    "checkedBy" TEXT,
    "authorizedBy" TEXT,
    "declaration" TEXT,
    "termsConditions" TEXT,

    CONSTRAINT "InvoiceAudit_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Invoice_orderReferenceId_key" ON "Invoice"("orderReferenceId");

-- CreateIndex
CREATE UNIQUE INDEX "Invoice_taxDetailId_key" ON "Invoice"("taxDetailId");

-- CreateIndex
CREATE UNIQUE INDEX "Invoice_transportDetailId_key" ON "Invoice"("transportDetailId");

-- CreateIndex
CREATE UNIQUE INDEX "Invoice_invoiceAmountSummaryId_key" ON "Invoice"("invoiceAmountSummaryId");

-- CreateIndex
CREATE UNIQUE INDEX "Invoice_invoiceAuditId_key" ON "Invoice"("invoiceAuditId");

-- CreateIndex
CREATE UNIQUE INDEX "Invoice_invoiceNumber_key" ON "Invoice"("invoiceNumber");

-- CreateIndex
CREATE UNIQUE INDEX "EInvoiceDetail_invoiceId_key" ON "EInvoiceDetail"("invoiceId");

-- CreateIndex
CREATE INDEX "DPR_project_id_idx" ON "DPR"("project_id");

-- CreateIndex
CREATE INDEX "DieselTransaction_project_id_idx" ON "DieselTransaction"("project_id");

-- CreateIndex
CREATE INDEX "PR_user_id_idx" ON "PR"("user_id");

-- AddForeignKey
ALTER TABLE "DPR" ADD CONSTRAINT "DPR_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DPR" ADD CONSTRAINT "DPR_submitted_by_fkey" FOREIGN KEY ("submitted_by") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PR" ADD CONSTRAINT "PR_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PR" ADD CONSTRAINT "PR_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DieselTransaction" ADD CONSTRAINT "DieselTransaction_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DieselTransaction" ADD CONSTRAINT "DieselTransaction_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "Seller"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_buyerId_fkey" FOREIGN KEY ("buyerId") REFERENCES "Buyer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_consigneeId_fkey" FOREIGN KEY ("consigneeId") REFERENCES "Consignee"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_orderReferenceId_fkey" FOREIGN KEY ("orderReferenceId") REFERENCES "OrderReference"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_taxDetailId_fkey" FOREIGN KEY ("taxDetailId") REFERENCES "TaxDetail"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_invoiceAmountSummaryId_fkey" FOREIGN KEY ("invoiceAmountSummaryId") REFERENCES "InvoiceAmountSummary"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_transportDetailId_fkey" FOREIGN KEY ("transportDetailId") REFERENCES "TransportDetail"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_invoiceAuditId_fkey" FOREIGN KEY ("invoiceAuditId") REFERENCES "InvoiceAudit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvoiceItem" ADD CONSTRAINT "InvoiceItem_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EInvoiceDetail" ADD CONSTRAINT "EInvoiceDetail_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "Invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;
