-- AlterTable
ALTER TABLE "GRN" ADD COLUMN     "created_by_id" INTEGER;

-- CreateTable
CREATE TABLE "PRGRN" (
    "id" SERIAL NOT NULL,
    "pr_id" INTEGER NOT NULL,
    "gate_entry_number" TEXT,
    "vehicle_number" TEXT,
    "driver_name" TEXT,
    "driver_contact" TEXT,
    "transport_mode" "TransportMode",
    "status" "ReceiptStatus" NOT NULL,
    "received_date" TIMESTAMP(3) NOT NULL,
    "received_time" TEXT,
    "quality_check_completed" BOOLEAN NOT NULL DEFAULT false,
    "grn_remarks" TEXT,
    "created_by_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PRGRN_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PRGRNMaterialReceipt" (
    "id" SERIAL NOT NULL,
    "grn_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "ordered" INTEGER NOT NULL,
    "chainage" TEXT,
    "quality" TEXT,
    "accepted" INTEGER NOT NULL,
    "rejected" INTEGER NOT NULL,
    "received" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PRGRNMaterialReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PRGRNFile" (
    "id" SERIAL NOT NULL,
    "grn_id" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,

    CONSTRAINT "PRGRNFile_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "PRGRN_pr_id_idx" ON "PRGRN"("pr_id");

-- CreateIndex
CREATE UNIQUE INDEX "PRGRNFile_grn_id_file_id_key" ON "PRGRNFile"("grn_id", "file_id");

-- AddForeignKey
ALTER TABLE "GRN" ADD CONSTRAINT "GRN_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRGRN" ADD CONSTRAINT "PRGRN_pr_id_fkey" FOREIGN KEY ("pr_id") REFERENCES "PR"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRGRN" ADD CONSTRAINT "PRGRN_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRGRNMaterialReceipt" ADD CONSTRAINT "PRGRNMaterialReceipt_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "PRGRN"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRGRNMaterialReceipt" ADD CONSTRAINT "PRGRNMaterialReceipt_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRGRNFile" ADD CONSTRAINT "PRGRNFile_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "PRGRN"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRGRNFile" ADD CONSTRAINT "PRGRNFile_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "File"("id") ON DELETE CASCADE ON UPDATE CASCADE;
