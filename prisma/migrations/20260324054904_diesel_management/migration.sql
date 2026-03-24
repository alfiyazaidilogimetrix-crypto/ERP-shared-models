-- AlterTable
ALTER TABLE "permissions" ADD COLUMN     "description" TEXT,
ADD COLUMN     "title" TEXT;

-- CreateTable
CREATE TABLE "diesel_consumption" (
    "id" SERIAL NOT NULL,
    "machine_id" INTEGER NOT NULL,
    "activity_id" INTEGER NOT NULL,
    "diesel_used_liters" INTEGER NOT NULL,
    "hours_used" INTEGER NOT NULL,
    "operator_name" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "issued_by" INTEGER NOT NULL,
    "remarks" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "diesel_consumption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diesel_supplier" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "contact_number" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "diesel_supplier_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diesel_inward" (
    "id" SERIAL NOT NULL,
    "supplier_id" INTEGER NOT NULL,
    "state" TEXT NOT NULL,
    "district" TEXT NOT NULL,
    "pincode" TEXT NOT NULL,
    "quantity_litres" DOUBLE PRECISION NOT NULL,
    "rate_per_litre" DOUBLE PRECISION NOT NULL,
    "total_amount" DOUBLE PRECISION NOT NULL,
    "delivery_person_name" TEXT,
    "vehicle_number" TEXT,
    "assigned_to" INTEGER NOT NULL,
    "received_by" TEXT NOT NULL,
    "received_at" TIMESTAMP(3) NOT NULL,
    "invoiceNumber" TEXT,
    "remarks" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "diesel_inward_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diesel_stock" (
    "id" SERIAL NOT NULL,
    "state" TEXT NOT NULL,
    "district" TEXT NOT NULL,
    "pincode" TEXT NOT NULL,
    "current_quantity_litres" DOUBLE PRECISION NOT NULL,
    "tank_capacity_litres" DOUBLE PRECISION,
    "manager_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "diesel_stock_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "machines" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "is_owned" BOOLEAN NOT NULL DEFAULT false,
    "rent_per_hour" TEXT,
    "purchase_cost" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "machines_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "diesel_consumption" ADD CONSTRAINT "diesel_consumption_machine_id_fkey" FOREIGN KEY ("machine_id") REFERENCES "machines"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_consumption" ADD CONSTRAINT "diesel_consumption_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_consumption" ADD CONSTRAINT "diesel_consumption_issued_by_fkey" FOREIGN KEY ("issued_by") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_inward" ADD CONSTRAINT "diesel_inward_supplier_id_fkey" FOREIGN KEY ("supplier_id") REFERENCES "diesel_supplier"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_inward" ADD CONSTRAINT "diesel_inward_assigned_to_fkey" FOREIGN KEY ("assigned_to") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_stock" ADD CONSTRAINT "diesel_stock_manager_id_fkey" FOREIGN KEY ("manager_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
