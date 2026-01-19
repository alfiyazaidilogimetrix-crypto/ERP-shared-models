-- CreateEnum
CREATE TYPE "ReceiptStatus" AS ENUM ('RECEIVED', 'ACCEPTED', 'REJECTED', 'PARTIALLY_ACCEPTED', 'PENDING');

-- CreateEnum
CREATE TYPE "POStatus" AS ENUM ('DRAFT', 'ISSUED', 'PARTIALLY_DELIVERED', 'DELIVERED', 'CANCELLED', 'CLOSED');

-- CreateEnum
CREATE TYPE "TransportMode" AS ENUM ('ROAD', 'RAIL', 'SEA', 'AIR', 'SELF_PICKUP');

-- CreateEnum
CREATE TYPE "PRStatus" AS ENUM ('DRAFT', 'SUBMITTED', 'APPROVED', 'REJECTED', 'CLOSED');

-- CreateEnum
CREATE TYPE "UrgencyLevel" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- CreateEnum
CREATE TYPE "DieselTransactionType" AS ENUM ('DIESEL_RECEIPT', 'DIESEL_ISSUE');

-- CreateEnum
CREATE TYPE "LabourStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'LEFT', 'BLACKLISTED');

-- CreateEnum
CREATE TYPE "LabourType" AS ENUM ('DIRECT', 'CONTRACT');

-- CreateEnum
CREATE TYPE "AttendanceStatus" AS ENUM ('PRESENT', 'ABSENT', 'HALF_DAY', 'ON_LEAVE');

-- CreateEnum
CREATE TYPE "ProjectType" AS ENUM ('HAM', 'EPC', 'BOT', 'OTHER');

-- CreateEnum
CREATE TYPE "ProjectStatus" AS ENUM ('PLANNED', 'IN_PROGRESS', 'ON_HOLD', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "Provider" AS ENUM ('credentials', 'google');

-- CreateEnum
CREATE TYPE "VendorStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "VendorType" AS ENUM ('DIRECT', 'INVENTORY');

-- CreateEnum
CREATE TYPE "SupplyStatus" AS ENUM ('PENDING', 'APPROVED', 'IN_TRANSIT', 'DELIVERED', 'REJECTED');

-- CreateTable
CREATE TABLE "DPR" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "project_id" INTEGER NOT NULL,
    "weather_condition" TEXT,
    "skilled_workers" INTEGER,
    "unskilled_workers" INTEGER,
    "contractor_name" TEXT,
    "safety_incidents" TEXT,
    "remarks" TEXT,
    "submitted_by" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DPR_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DPRWorkActivity" (
    "id" SERIAL NOT NULL,
    "dpr_id" INTEGER NOT NULL,
    "activity_description" TEXT NOT NULL,
    "chainage" TEXT,
    "planned_qty" TEXT,
    "actual_qty" TEXT,
    "progress" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DPRWorkActivity_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DPRMaterialConsumption" (
    "id" SERIAL NOT NULL,
    "dpr_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "quantity" TEXT NOT NULL,
    "chainage" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DPRMaterialConsumption_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DPRMachineryUsage" (
    "id" SERIAL NOT NULL,
    "dpr_id" INTEGER NOT NULL,
    "equipment_name" TEXT NOT NULL,
    "working_hours" TEXT,
    "idle_hours" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DPRMachineryUsage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GRN" (
    "id" SERIAL NOT NULL,
    "po_id" INTEGER NOT NULL,
    "gate_entry_number" TEXT,
    "vehicle_number" TEXT,
    "driver_name" TEXT,
    "driver_contact" TEXT,
    "transport_mode" "TransportMode",
    "status" "ReceiptStatus" NOT NULL,
    "received_date" TIMESTAMP(3) NOT NULL,
    "received_time" TEXT,
    "store_location" TEXT,
    "quality_check_completed" BOOLEAN NOT NULL DEFAULT false,
    "grn_remarks" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GRN_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GRNMaterialReceipt" (
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

    CONSTRAINT "GRNMaterialReceipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PO" (
    "id" SERIAL NOT NULL,
    "pr_id" INTEGER NOT NULL,
    "project_id" INTEGER NOT NULL,
    "vendor_id" INTEGER NOT NULL,
    "po_code" TEXT NOT NULL,
    "po_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expected_delivery_date" TIMESTAMP(3),
    "transport_mode" "TransportMode",
    "total_amount" TEXT NOT NULL,
    "po_status" "POStatus" NOT NULL DEFAULT 'DRAFT',
    "payment_terms" TEXT,
    "delivery_terms" TEXT,
    "shipping_address" TEXT,
    "billing_address" TEXT,
    "remarks" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PO_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "POOrderItem" (
    "id" SERIAL NOT NULL,
    "po_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "quantity" TEXT NOT NULL,
    "rate" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "POOrderItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PR" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "pr_code" TEXT NOT NULL,
    "urgency_level" "UrgencyLevel" NOT NULL,
    "status" "PRStatus" NOT NULL DEFAULT 'DRAFT',
    "remarks" TEXT,
    "user_id" INTEGER,
    "approved_by" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PR_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PRMaterialItem" (
    "id" SERIAL NOT NULL,
    "pr_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "quantity" TEXT NOT NULL,
    "required_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PRMaterialItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Chainage_consumption_ledger" (
    "id" SERIAL NOT NULL,
    "chainage_data" JSONB NOT NULL,
    "projectId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Chainage_consumption_ledger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DieselTransaction" (
    "id" SERIAL NOT NULL,
    "transaction_type" "DieselTransactionType" NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "project_id" INTEGER NOT NULL,
    "vendor_id" INTEGER,
    "invoice_number" TEXT,
    "quantity" TEXT,
    "rate_per_litre" TEXT,
    "total_amount" TEXT,
    "equipment_name" TEXT,
    "vehicle_number" TEXT,
    "purpose" TEXT,
    "issue_rate_per_litre" TEXT,
    "remarks" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DieselTransaction_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "File" (
    "id" SERIAL NOT NULL,
    "filename" TEXT NOT NULL,
    "originalName" TEXT NOT NULL,
    "mimeType" TEXT NOT NULL,
    "size" INTEGER NOT NULL,
    "filePath" TEXT NOT NULL,
    "fileContent" BYTEA NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "File_pkey" PRIMARY KEY ("id")
);

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

-- CreateTable
CREATE TABLE "Labour" (
    "id" SERIAL NOT NULL,
    "labour_name" TEXT NOT NULL,
    "labour_code" TEXT NOT NULL,
    "labour_type" "LabourType" NOT NULL,
    "skill" TEXT NOT NULL,
    "phone_number" TEXT,
    "aadhar_number" TEXT,
    "address" TEXT,
    "joining_date" TIMESTAMP(3),
    "status" "LabourStatus" NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Labour_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabourAttendance" (
    "id" TEXT NOT NULL,
    "labour_id" INTEGER NOT NULL,
    "project_id" INTEGER NOT NULL,
    "date" DATE NOT NULL,
    "check_in_time" TIMESTAMP(3),
    "check_out_time" TIMESTAMP(3),
    "total_working_hours" DOUBLE PRECISION,
    "field_working_hours" DOUBLE PRECISION,
    "overtime_hours" DOUBLE PRECISION,
    "status" "AttendanceStatus" NOT NULL,
    "chainage_from" TEXT,
    "chainage_to" TEXT,
    "remarks" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LabourAttendance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "materials" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "material_code" TEXT,
    "categoryId" INTEGER,
    "unitId" INTEGER,
    "status" TEXT NOT NULL DEFAULT 'active',
    "minimum_threshold_quantity" INTEGER,
    "unit_of_measure" TEXT,
    "specifications" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "materials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Module" (
    "id" SERIAL NOT NULL,
    "Name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Module_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" SERIAL NOT NULL,
    "action" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Project" (
    "id" SERIAL NOT NULL,
    "project_type" "ProjectType" NOT NULL,
    "project_name" TEXT NOT NULL,
    "project_code" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "budget" TEXT,
    "status" "ProjectStatus" NOT NULL DEFAULT 'PLANNED',
    "client" TEXT,
    "project_manager" TEXT,
    "description" TEXT,
    "progress" INTEGER,
    "other_details" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "HAMSpecificDetails" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "annuity_amount" TEXT,
    "annuity_period" INTEGER,
    "construction_period" INTEGER,
    "maintenance_responsibility" TEXT,
    "progress" INTEGER,

    CONSTRAINT "HAMSpecificDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EPCSpecificDetails" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "engineering_scope" TEXT,
    "procurement_budget" TEXT,
    "construction_timeline" TEXT,
    "performance_guarantee" TEXT,
    "progress" INTEGER,

    CONSTRAINT "EPCSpecificDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BOTSpecificDetails" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "concession_period" INTEGER,
    "estimated_operating_cost" TEXT,
    "toll_revenue_collection_enabled" BOOLEAN NOT NULL DEFAULT false,
    "transfer_condition" TEXT,

    CONSTRAINT "BOTSpecificDetails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

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

-- CreateTable
CREATE TABLE "sub_contractors" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "scope_of_work" TEXT,
    "contract_value" TEXT,
    "chainage_start_km" TEXT,
    "chainage_end_km" TEXT,
    "contract_start_date" TIMESTAMP(3),
    "contract_end_date" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sub_contractors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contractor_vendors" (
    "id" SERIAL NOT NULL,
    "contractorId" INTEGER NOT NULL,
    "vendorId" INTEGER NOT NULL,

    CONSTRAINT "contractor_vendors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contractor_projects" (
    "id" SERIAL NOT NULL,
    "contractorId" INTEGER NOT NULL,
    "projectId" INTEGER NOT NULL,

    CONSTRAINT "contractor_projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "units" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "emailVerified" BOOLEAN NOT NULL DEFAULT false,
    "password" TEXT NOT NULL,
    "fileId" INTEGER,
    "original_password" TEXT,
    "mobileNumber" TEXT,
    "roleId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "provider" "Provider" NOT NULL DEFAULT 'credentials',

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vendor" (
    "id" SERIAL NOT NULL,
    "vendor_name" TEXT NOT NULL,
    "category_id" INTEGER NOT NULL,
    "contact_number" TEXT,
    "email_address" TEXT,
    "address" TEXT,
    "gst_number" TEXT,
    "pan_number" TEXT,
    "status" "VendorStatus" NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Vendor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VendorSupplyManagement" (
    "id" SERIAL NOT NULL,
    "vendor_type" "VendorType" NOT NULL,
    "vendor_id" INTEGER NOT NULL,
    "stock_id" INTEGER,
    "quantity" TEXT NOT NULL,
    "unit" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "payment_terms" TEXT,
    "status" "SupplyStatus" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "materialId" INTEGER,

    CONSTRAINT "VendorSupplyManagement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DirectSupplyConfiguration" (
    "id" SERIAL NOT NULL,
    "supply_id" INTEGER NOT NULL,
    "project_id" INTEGER NOT NULL,
    "chainage_location" TEXT,
    "delivery_location" TEXT,
    "fob_destination" TEXT,

    CONSTRAINT "DirectSupplyConfiguration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InventorySupplyConfiguration" (
    "id" SERIAL NOT NULL,
    "supply_id" INTEGER NOT NULL,
    "warehouse_location" TEXT,
    "expected_delivery_date" TIMESTAMP(3),
    "batch_number" TEXT,
    "quality_check_status" TEXT,

    CONSTRAINT "InventorySupplyConfiguration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PermissionModules" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_PermissionModules_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateTable
CREATE TABLE "_RolePermissions" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,

    CONSTRAINT "_RolePermissions_AB_pkey" PRIMARY KEY ("A","B")
);

-- CreateIndex
CREATE INDEX "DPR_project_id_idx" ON "DPR"("project_id");

-- CreateIndex
CREATE INDEX "DPR_date_idx" ON "DPR"("date");

-- CreateIndex
CREATE INDEX "GRN_po_id_idx" ON "GRN"("po_id");

-- CreateIndex
CREATE UNIQUE INDEX "PO_po_code_key" ON "PO"("po_code");

-- CreateIndex
CREATE INDEX "PO_pr_id_idx" ON "PO"("pr_id");

-- CreateIndex
CREATE INDEX "PO_project_id_idx" ON "PO"("project_id");

-- CreateIndex
CREATE INDEX "PO_vendor_id_idx" ON "PO"("vendor_id");

-- CreateIndex
CREATE UNIQUE INDEX "PR_pr_code_key" ON "PR"("pr_code");

-- CreateIndex
CREATE INDEX "PR_project_id_idx" ON "PR"("project_id");

-- CreateIndex
CREATE INDEX "PR_user_id_idx" ON "PR"("user_id");

-- CreateIndex
CREATE INDEX "DieselTransaction_project_id_idx" ON "DieselTransaction"("project_id");

-- CreateIndex
CREATE INDEX "DieselTransaction_transaction_type_idx" ON "DieselTransaction"("transaction_type");

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
CREATE UNIQUE INDEX "Labour_labour_code_key" ON "Labour"("labour_code");

-- CreateIndex
CREATE UNIQUE INDEX "Labour_aadhar_number_key" ON "Labour"("aadhar_number");

-- CreateIndex
CREATE INDEX "Labour_labour_type_idx" ON "Labour"("labour_type");

-- CreateIndex
CREATE INDEX "Labour_status_idx" ON "Labour"("status");

-- CreateIndex
CREATE INDEX "LabourAttendance_labour_id_date_idx" ON "LabourAttendance"("labour_id", "date");

-- CreateIndex
CREATE INDEX "LabourAttendance_project_id_idx" ON "LabourAttendance"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "materials_material_code_key" ON "materials"("material_code");

-- CreateIndex
CREATE UNIQUE INDEX "HAMSpecificDetails_project_id_key" ON "HAMSpecificDetails"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "EPCSpecificDetails_project_id_key" ON "EPCSpecificDetails"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "BOTSpecificDetails_project_id_key" ON "BOTSpecificDetails"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Stock_material_code_key" ON "Stock"("material_code");

-- CreateIndex
CREATE UNIQUE INDEX "contractor_vendors_contractorId_vendorId_key" ON "contractor_vendors"("contractorId", "vendorId");

-- CreateIndex
CREATE UNIQUE INDEX "contractor_projects_contractorId_projectId_key" ON "contractor_projects"("contractorId", "projectId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "DirectSupplyConfiguration_supply_id_key" ON "DirectSupplyConfiguration"("supply_id");

-- CreateIndex
CREATE UNIQUE INDEX "InventorySupplyConfiguration_supply_id_key" ON "InventorySupplyConfiguration"("supply_id");

-- CreateIndex
CREATE INDEX "_PermissionModules_B_index" ON "_PermissionModules"("B");

-- CreateIndex
CREATE INDEX "_RolePermissions_B_index" ON "_RolePermissions"("B");

-- AddForeignKey
ALTER TABLE "DPR" ADD CONSTRAINT "DPR_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DPR" ADD CONSTRAINT "DPR_submitted_by_fkey" FOREIGN KEY ("submitted_by") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DPRWorkActivity" ADD CONSTRAINT "DPRWorkActivity_dpr_id_fkey" FOREIGN KEY ("dpr_id") REFERENCES "DPR"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DPRMaterialConsumption" ADD CONSTRAINT "DPRMaterialConsumption_dpr_id_fkey" FOREIGN KEY ("dpr_id") REFERENCES "DPR"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DPRMachineryUsage" ADD CONSTRAINT "DPRMachineryUsage_dpr_id_fkey" FOREIGN KEY ("dpr_id") REFERENCES "DPR"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GRN" ADD CONSTRAINT "GRN_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "PO"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GRNMaterialReceipt" ADD CONSTRAINT "GRNMaterialReceipt_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "GRN"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GRNMaterialReceipt" ADD CONSTRAINT "GRNMaterialReceipt_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PO" ADD CONSTRAINT "PO_pr_id_fkey" FOREIGN KEY ("pr_id") REFERENCES "PR"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PO" ADD CONSTRAINT "PO_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PO" ADD CONSTRAINT "PO_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "POOrderItem" ADD CONSTRAINT "POOrderItem_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "PO"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "POOrderItem" ADD CONSTRAINT "POOrderItem_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PR" ADD CONSTRAINT "PR_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PR" ADD CONSTRAINT "PR_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PR" ADD CONSTRAINT "PR_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRMaterialItem" ADD CONSTRAINT "PRMaterialItem_pr_id_fkey" FOREIGN KEY ("pr_id") REFERENCES "PR"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PRMaterialItem" ADD CONSTRAINT "PRMaterialItem_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chainage_consumption_ledger" ADD CONSTRAINT "Chainage_consumption_ledger_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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

-- AddForeignKey
ALTER TABLE "LabourAttendance" ADD CONSTRAINT "LabourAttendance_labour_id_fkey" FOREIGN KEY ("labour_id") REFERENCES "Labour"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabourAttendance" ADD CONSTRAINT "LabourAttendance_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materials" ADD CONSTRAINT "materials_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materials" ADD CONSTRAINT "materials_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "units"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HAMSpecificDetails" ADD CONSTRAINT "HAMSpecificDetails_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EPCSpecificDetails" ADD CONSTRAINT "EPCSpecificDetails_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BOTSpecificDetails" ADD CONSTRAINT "BOTSpecificDetails_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "categories"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Stock" ADD CONSTRAINT "Stock_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "units"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_vendors" ADD CONSTRAINT "contractor_vendors_contractorId_fkey" FOREIGN KEY ("contractorId") REFERENCES "sub_contractors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_vendors" ADD CONSTRAINT "contractor_vendors_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "Vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_projects" ADD CONSTRAINT "contractor_projects_contractorId_fkey" FOREIGN KEY ("contractorId") REFERENCES "sub_contractors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_projects" ADD CONSTRAINT "contractor_projects_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "File"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vendor" ADD CONSTRAINT "Vendor_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorSupplyManagement" ADD CONSTRAINT "VendorSupplyManagement_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "Vendor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorSupplyManagement" ADD CONSTRAINT "VendorSupplyManagement_stock_id_fkey" FOREIGN KEY ("stock_id") REFERENCES "Stock"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "VendorSupplyManagement" ADD CONSTRAINT "VendorSupplyManagement_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "materials"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DirectSupplyConfiguration" ADD CONSTRAINT "DirectSupplyConfiguration_supply_id_fkey" FOREIGN KEY ("supply_id") REFERENCES "VendorSupplyManagement"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DirectSupplyConfiguration" ADD CONSTRAINT "DirectSupplyConfiguration_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InventorySupplyConfiguration" ADD CONSTRAINT "InventorySupplyConfiguration_supply_id_fkey" FOREIGN KEY ("supply_id") REFERENCES "VendorSupplyManagement"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionModules" ADD CONSTRAINT "_PermissionModules_A_fkey" FOREIGN KEY ("A") REFERENCES "Module"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionModules" ADD CONSTRAINT "_PermissionModules_B_fkey" FOREIGN KEY ("B") REFERENCES "Permission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RolePermissions" ADD CONSTRAINT "_RolePermissions_A_fkey" FOREIGN KEY ("A") REFERENCES "Permission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RolePermissions" ADD CONSTRAINT "_RolePermissions_B_fkey" FOREIGN KEY ("B") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE CASCADE;
