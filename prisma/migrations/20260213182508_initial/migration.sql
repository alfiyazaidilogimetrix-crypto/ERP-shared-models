-- CreateEnum
CREATE TYPE "Site_type" AS ENUM ('LHS', 'RHS', 'BHS');

-- CreateEnum
CREATE TYPE "ReceiptStatus" AS ENUM ('RECEIVED', 'ACCEPTED', 'REJECTED', 'PARTIALLY_ACCEPTED', 'PENDING');

-- CreateEnum
CREATE TYPE "POStatus" AS ENUM ('DRAFT', 'ISSUED', 'PARTIALLY_DELIVERED', 'DELIVERED', 'CANCELLED', 'CLOSED');

-- CreateEnum
CREATE TYPE "TransportMode" AS ENUM ('ROAD', 'RAIL', 'SEA', 'AIR', 'SELF_PICKUP');

-- CreateEnum
CREATE TYPE "PRStatus" AS ENUM ('DRAFT', 'SUBMITTED', 'INVENTORY_CHECK', 'PARTIAL_AVAILABLE', 'PROCUREMENT_REQUIRED', 'APPROVED', 'REJECTED', 'CLOSED');

-- CreateEnum
CREATE TYPE "UrgencyLevel" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL');

-- CreateEnum
CREATE TYPE "PRType" AS ENUM ('INVENTORY', 'PROCUREMENT', 'NONE');

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
CREATE TYPE "StockStatus" AS ENUM ('IN_STOCK', 'LOW_STOCK', 'OUT_OF_STOCK', 'RESERVED', 'DAMAGED', 'DISPOSED');

-- CreateEnum
CREATE TYPE "VendorStatus" AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "VendorType" AS ENUM ('SUB_CONTRACTOR', 'MATERIAL_SUPPLIER');

-- CreateEnum
CREATE TYPE "SupplyStatus" AS ENUM ('PENDING', 'APPROVED', 'IN_TRANSIT', 'PARTIALLY_RECEIVED', 'RECEIVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "SupplyType" AS ENUM ('TO_INVENTORY', 'DIRECT_TO_SITE');

-- CreateTable
CREATE TABLE "dprs" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "project_id" INTEGER NOT NULL,
    "site" "Site_type" NOT NULL,
    "chainage" TEXT[],
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
    "submitted_by" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dprs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dpr_files" (
    "id" SERIAL NOT NULL,
    "dpr_id" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,

    CONSTRAINT "dpr_files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grn" (
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
    "created_by_id" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "grn_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grn_matrial_receipt" (
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

    CONSTRAINT "grn_matrial_receipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grn_file" (
    "id" SERIAL NOT NULL,
    "grn_id" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,

    CONSTRAINT "grn_file_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pos" (
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

    CONSTRAINT "pos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "po_order_items" (
    "id" SERIAL NOT NULL,
    "po_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "quantity" TEXT NOT NULL,
    "rate" TEXT NOT NULL,
    "amount" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "po_order_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "prs" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "pr_code" TEXT NOT NULL,
    "pr_type" "PRType" NOT NULL DEFAULT 'NONE',
    "urgency_level" "UrgencyLevel" NOT NULL,
    "status" "PRStatus" NOT NULL DEFAULT 'DRAFT',
    "remarks" TEXT,
    "user_id" INTEGER,
    "approved_by" INTEGER,
    "send_to" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "prs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pr_material_items" (
    "id" SERIAL NOT NULL,
    "pr_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "quantity" TEXT NOT NULL,
    "required_date" TIMESTAMP(3) NOT NULL,
    "is_approved" BOOLEAN NOT NULL DEFAULT false,
    "approved_qty" TEXT,
    "approval_remarks" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pr_material_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "activities" (
    "id" SERIAL NOT NULL,
    "category_type" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "activities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "chainage_consumption_ledger" (
    "id" SERIAL NOT NULL,
    "chainage_data" JSONB NOT NULL,
    "projectId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "chainage_consumption_ledger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diesel_transactions" (
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

    CONSTRAINT "diesel_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "files" (
    "id" SERIAL NOT NULL,
    "filename" TEXT NOT NULL,
    "originalName" TEXT NOT NULL,
    "mimeType" TEXT NOT NULL,
    "size" INTEGER NOT NULL,
    "filePath" TEXT NOT NULL,
    "fileContent" BYTEA NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_manager" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "inventory_manager_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_stock_entry" (
    "id" SERIAL NOT NULL,
    "inventoryId" INTEGER NOT NULL,
    "stockId" INTEGER NOT NULL,

    CONSTRAINT "inventory_stock_entry_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_history" (
    "id" SERIAL NOT NULL,
    "manager_id" INTEGER NOT NULL,
    "project_id" INTEGER NOT NULL,
    "total_amount" DOUBLE PRECISION,
    "items_data" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "inventory_history_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice" (
    "id" SERIAL NOT NULL,
    "invoiceNumber" TEXT NOT NULL,
    "invoiceDate" TIMESTAMP(3) NOT NULL,
    "invoiceType" TEXT NOT NULL,
    "reverseCharge" BOOLEAN NOT NULL DEFAULT false,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "po_id" INTEGER NOT NULL,
    "sellerId" INTEGER NOT NULL,
    "consigneeId" INTEGER,
    "taxDetailId" INTEGER,
    "amountSummaryId" INTEGER,
    "transportDetailId" INTEGER,
    "auditDetailId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "buyer" TEXT,
    "invoiceAmountSummaryId" INTEGER,
    "invoiceAuditId" INTEGER,
    "userId" INTEGER,

    CONSTRAINT "invoice_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_item" (
    "id" SERIAL NOT NULL,
    "invoiceId" INTEGER NOT NULL,
    "grn_id" INTEGER NOT NULL,
    "grn_material_receipt_id" INTEGER NOT NULL,
    "basicAmount" DOUBLE PRECISION,
    "taxableValue" DOUBLE PRECISION,
    "freightRatePerUnit" DOUBLE PRECISION,
    "unloadingRatePerUnit" DOUBLE PRECISION,

    CONSTRAINT "invoice_item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tax_detail" (
    "id" SERIAL NOT NULL,
    "cgstRate" DOUBLE PRECISION,
    "cgstAmount" DOUBLE PRECISION,
    "sgstRate" DOUBLE PRECISION,
    "sgstAmount" DOUBLE PRECISION,
    "igstRate" DOUBLE PRECISION,
    "igstAmount" DOUBLE PRECISION,
    "totalTax" DOUBLE PRECISION,
    "invoiceId" INTEGER,

    CONSTRAINT "tax_detail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_amount_summary" (
    "id" SERIAL NOT NULL,
    "goodsValue" DOUBLE PRECISION,
    "taxableValue" DOUBLE PRECISION,
    "freightAmount" DOUBLE PRECISION,
    "unloadingAmount" DOUBLE PRECISION,
    "roundOff" DOUBLE PRECISION,
    "totalTaxAmount" DOUBLE PRECISION,
    "totalInvoiceValue" DOUBLE PRECISION,
    "amountInWords" TEXT NOT NULL,
    "invoiceId" INTEGER,

    CONSTRAINT "invoice_amount_summary_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transport_detail" (
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
    "invoiceId" INTEGER,

    CONSTRAINT "transport_detail_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "invoice_audit" (
    "id" SERIAL NOT NULL,
    "preparedBy" TEXT,
    "checkedBy" TEXT,
    "authorizedBy" TEXT,
    "declaration" TEXT,
    "termsConditions" TEXT,
    "invoiceId" INTEGER,

    CONSTRAINT "invoice_audit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "labours" (
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

    CONSTRAINT "labours_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "labour_attendance" (
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

    CONSTRAINT "labour_attendance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "materials" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "material_code" TEXT,
    "activityId" INTEGER,
    "unitId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "materials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "modules" (
    "id" SERIAL NOT NULL,
    "Name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "modules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permissions" (
    "id" SERIAL NOT NULL,
    "action" TEXT[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pr_grns" (
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

    CONSTRAINT "pr_grns_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pr_grn_material_receipt" (
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

    CONSTRAINT "pr_grn_material_receipt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pr_grn_files" (
    "id" SERIAL NOT NULL,
    "grn_id" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,

    CONSTRAINT "pr_grn_files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "project" (
    "id" SERIAL NOT NULL,
    "project_type" "ProjectType" NOT NULL,
    "project_name" TEXT NOT NULL,
    "project_code" TEXT NOT NULL,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "budget" TEXT,
    "status" "ProjectStatus" NOT NULL DEFAULT 'PLANNED',
    "client" TEXT,
    "description" TEXT,
    "progress" INTEGER,
    "manager_id" INTEGER,
    "district" TEXT,
    "state" TEXT,
    "pincode" TEXT,
    "from_length" TEXT,
    "to_length" TEXT,
    "total_length" TEXT,
    "total_chainage" TEXT[],
    "other_details" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "project_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ham_specific_details" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "annuity_amount" TEXT,
    "annuity_period" INTEGER,
    "construction_period" INTEGER,
    "maintenance_responsibility" TEXT,
    "progress" INTEGER,

    CONSTRAINT "ham_specific_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "epc_specific_details" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "engineering_scope" TEXT,
    "procurement_budget" TEXT,
    "construction_timeline" TEXT,
    "performance_guarantee" TEXT,
    "progress" INTEGER,

    CONSTRAINT "epc_specific_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bot_specific_details" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "concession_period" INTEGER,
    "estimated_operating_cost" TEXT,
    "toll_revenue_collection_enabled" BOOLEAN NOT NULL DEFAULT false,
    "transfer_condition" TEXT,

    CONSTRAINT "bot_specific_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "scopes" (
    "id" SERIAL NOT NULL,
    "activity_id" INTEGER NOT NULL,
    "length" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "scopes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stock" (
    "id" SERIAL NOT NULL,
    "material_id" INTEGER NOT NULL,
    "locationId" INTEGER,
    "status" "StockStatus" NOT NULL DEFAULT 'IN_STOCK',
    "minimum_threshold_quantity" INTEGER,
    "current_stock" INTEGER,
    "quantity" INTEGER,
    "specifications" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "stock_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contractor_projects" (
    "id" SERIAL NOT NULL,
    "contractorId" INTEGER NOT NULL,
    "projectId" INTEGER NOT NULL,
    "partnership_percentage" TEXT,
    "start_date" TIMESTAMP(3),
    "end_date" TIMESTAMP(3),
    "overall_budget" TEXT,
    "from_chainage" TEXT,
    "to_chainage" TEXT,

    CONSTRAINT "contractor_projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contractor_files" (
    "id" SERIAL NOT NULL,
    "contractorProjectId" INTEGER NOT NULL,
    "file_id" INTEGER NOT NULL,
    "report_type" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "contractor_files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "units" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
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

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendor" (
    "id" SERIAL NOT NULL,
    "vendor_name" TEXT NOT NULL,
    "proprietor_name" TEXT,
    "contact_person" TEXT,
    "contact_number" TEXT NOT NULL,
    "email_address" TEXT,
    "address" TEXT NOT NULL,
    "registered_address" TEXT,
    "vendor_type" "VendorType",
    "status" "VendorStatus" NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vendor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendor_bank_details" (
    "id" SERIAL NOT NULL,
    "vendorId" INTEGER NOT NULL,
    "bank_name" TEXT NOT NULL,
    "branch_name" TEXT,
    "bank_address" TEXT,
    "bank_contact_number" TEXT,
    "account_number" TEXT NOT NULL,
    "ifsc_code" TEXT NOT NULL,
    "micr_code" TEXT,
    "rtgs_code" TEXT,
    "neft_code" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vendor_bank_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendor_financial_details" (
    "id" SERIAL NOT NULL,
    "vendorId" INTEGER NOT NULL,
    "registration_number" TEXT,
    "pan_number" TEXT NOT NULL,
    "esi_number" TEXT,
    "pf_number" TEXT,
    "gst_number" TEXT,
    "gst_state" TEXT,
    "annual_turnover" TEXT,
    "audited_balance_years" TEXT,
    "yearly_work_capacity" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vendor_financial_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendor_other_details" (
    "id" SERIAL NOT NULL,
    "vendorId" INTEGER NOT NULL,
    "organization_type" TEXT,
    "total_team_size" TEXT,
    "plant_and_machinery" TEXT,
    "organization_chart" TEXT,
    "interested_other_work" TEXT,
    "association_status" TEXT,
    "geographical_presence" TEXT,
    "major_clients" TEXT,
    "sop_qap_signoff" TEXT,
    "sop_quality_manual" TEXT,
    "relative_experience" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vendor_other_details_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendor_documents" (
    "id" SERIAL NOT NULL,
    "vendorId" INTEGER NOT NULL,
    "file_id" INTEGER,
    "document_type" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vendor_documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vendor_supply_management" (
    "id" SERIAL NOT NULL,
    "vendor_id" INTEGER NOT NULL,
    "supply_type" "SupplyType" NOT NULL,
    "po_id" INTEGER,
    "amount" TEXT NOT NULL,
    "payment_terms" TEXT,
    "status" "SupplyStatus" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vendor_supply_management_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "direct_supply_configuration" (
    "id" SERIAL NOT NULL,
    "supply_id" INTEGER NOT NULL,
    "project_id" INTEGER NOT NULL,
    "chainage_location" TEXT,
    "delivery_location" TEXT,
    "fob_destination" TEXT,

    CONSTRAINT "direct_supply_configuration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "inventory_supply_configuration" (
    "id" SERIAL NOT NULL,
    "supply_id" INTEGER NOT NULL,
    "warehouse_location" TEXT,
    "expected_delivery_date" TIMESTAMP(3),
    "batch_number" TEXT,
    "quality_check_status" TEXT,

    CONSTRAINT "inventory_supply_configuration_pkey" PRIMARY KEY ("id")
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
CREATE INDEX "dprs_project_id_idx" ON "dprs"("project_id");

-- CreateIndex
CREATE INDEX "dprs_date_idx" ON "dprs"("date");

-- CreateIndex
CREATE UNIQUE INDEX "dpr_files_dpr_id_file_id_key" ON "dpr_files"("dpr_id", "file_id");

-- CreateIndex
CREATE INDEX "grn_po_id_idx" ON "grn"("po_id");

-- CreateIndex
CREATE UNIQUE INDEX "grn_file_grn_id_file_id_key" ON "grn_file"("grn_id", "file_id");

-- CreateIndex
CREATE UNIQUE INDEX "pos_po_code_key" ON "pos"("po_code");

-- CreateIndex
CREATE INDEX "pos_pr_id_idx" ON "pos"("pr_id");

-- CreateIndex
CREATE INDEX "pos_project_id_idx" ON "pos"("project_id");

-- CreateIndex
CREATE INDEX "pos_vendor_id_idx" ON "pos"("vendor_id");

-- CreateIndex
CREATE UNIQUE INDEX "prs_pr_code_key" ON "prs"("pr_code");

-- CreateIndex
CREATE INDEX "prs_project_id_idx" ON "prs"("project_id");

-- CreateIndex
CREATE INDEX "prs_user_id_idx" ON "prs"("user_id");

-- CreateIndex
CREATE INDEX "diesel_transactions_project_id_idx" ON "diesel_transactions"("project_id");

-- CreateIndex
CREATE INDEX "diesel_transactions_transaction_type_idx" ON "diesel_transactions"("transaction_type");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_manager_userId_key" ON "inventory_manager"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_stock_entry_inventoryId_stockId_key" ON "inventory_stock_entry"("inventoryId", "stockId");

-- CreateIndex
CREATE UNIQUE INDEX "invoice_invoiceNumber_key" ON "invoice"("invoiceNumber");

-- CreateIndex
CREATE INDEX "invoice_item_grn_id_idx" ON "invoice_item"("grn_id");

-- CreateIndex
CREATE UNIQUE INDEX "tax_detail_invoiceId_key" ON "tax_detail"("invoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "invoice_amount_summary_invoiceId_key" ON "invoice_amount_summary"("invoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "transport_detail_invoiceId_key" ON "transport_detail"("invoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "invoice_audit_invoiceId_key" ON "invoice_audit"("invoiceId");

-- CreateIndex
CREATE UNIQUE INDEX "labours_labour_code_key" ON "labours"("labour_code");

-- CreateIndex
CREATE UNIQUE INDEX "labours_aadhar_number_key" ON "labours"("aadhar_number");

-- CreateIndex
CREATE INDEX "labours_labour_type_idx" ON "labours"("labour_type");

-- CreateIndex
CREATE INDEX "labours_status_idx" ON "labours"("status");

-- CreateIndex
CREATE INDEX "labour_attendance_labour_id_date_idx" ON "labour_attendance"("labour_id", "date");

-- CreateIndex
CREATE INDEX "labour_attendance_project_id_idx" ON "labour_attendance"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "materials_material_code_key" ON "materials"("material_code");

-- CreateIndex
CREATE INDEX "pr_grns_pr_id_idx" ON "pr_grns"("pr_id");

-- CreateIndex
CREATE UNIQUE INDEX "pr_grn_files_grn_id_file_id_key" ON "pr_grn_files"("grn_id", "file_id");

-- CreateIndex
CREATE UNIQUE INDEX "ham_specific_details_project_id_key" ON "ham_specific_details"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "epc_specific_details_project_id_key" ON "epc_specific_details"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "bot_specific_details_project_id_key" ON "bot_specific_details"("project_id");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "contractor_projects_contractorId_projectId_key" ON "contractor_projects"("contractorId", "projectId");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "vendor_bank_details_vendorId_key" ON "vendor_bank_details"("vendorId");

-- CreateIndex
CREATE UNIQUE INDEX "vendor_financial_details_vendorId_key" ON "vendor_financial_details"("vendorId");

-- CreateIndex
CREATE UNIQUE INDEX "vendor_other_details_vendorId_key" ON "vendor_other_details"("vendorId");

-- CreateIndex
CREATE UNIQUE INDEX "direct_supply_configuration_supply_id_key" ON "direct_supply_configuration"("supply_id");

-- CreateIndex
CREATE UNIQUE INDEX "inventory_supply_configuration_supply_id_key" ON "inventory_supply_configuration"("supply_id");

-- CreateIndex
CREATE INDEX "_PermissionModules_B_index" ON "_PermissionModules"("B");

-- CreateIndex
CREATE INDEX "_RolePermissions_B_index" ON "_RolePermissions"("B");

-- AddForeignKey
ALTER TABLE "dprs" ADD CONSTRAINT "dprs_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dprs" ADD CONSTRAINT "dprs_sub_activity_id_fkey" FOREIGN KEY ("sub_activity_id") REFERENCES "materials"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dprs" ADD CONSTRAINT "dprs_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dprs" ADD CONSTRAINT "dprs_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dprs" ADD CONSTRAINT "dprs_submitted_by_fkey" FOREIGN KEY ("submitted_by") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dpr_files" ADD CONSTRAINT "dpr_files_dpr_id_fkey" FOREIGN KEY ("dpr_id") REFERENCES "dprs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dpr_files" ADD CONSTRAINT "dpr_files_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "grn" ADD CONSTRAINT "grn_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "pos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "grn" ADD CONSTRAINT "grn_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "grn_matrial_receipt" ADD CONSTRAINT "grn_matrial_receipt_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "grn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "grn_matrial_receipt" ADD CONSTRAINT "grn_matrial_receipt_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "grn_file" ADD CONSTRAINT "grn_file_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "grn"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "grn_file" ADD CONSTRAINT "grn_file_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pos" ADD CONSTRAINT "pos_pr_id_fkey" FOREIGN KEY ("pr_id") REFERENCES "prs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pos" ADD CONSTRAINT "pos_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pos" ADD CONSTRAINT "pos_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "po_order_items" ADD CONSTRAINT "po_order_items_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "pos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "po_order_items" ADD CONSTRAINT "po_order_items_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prs" ADD CONSTRAINT "prs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prs" ADD CONSTRAINT "prs_send_to_fkey" FOREIGN KEY ("send_to") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prs" ADD CONSTRAINT "prs_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "prs" ADD CONSTRAINT "prs_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_material_items" ADD CONSTRAINT "pr_material_items_pr_id_fkey" FOREIGN KEY ("pr_id") REFERENCES "prs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_material_items" ADD CONSTRAINT "pr_material_items_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "activities" ADD CONSTRAINT "activities_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chainage_consumption_ledger" ADD CONSTRAINT "chainage_consumption_ledger_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_transactions" ADD CONSTRAINT "diesel_transactions_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "vendor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "diesel_transactions" ADD CONSTRAINT "diesel_transactions_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_manager" ADD CONSTRAINT "inventory_manager_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_stock_entry" ADD CONSTRAINT "inventory_stock_entry_inventoryId_fkey" FOREIGN KEY ("inventoryId") REFERENCES "inventory_manager"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_stock_entry" ADD CONSTRAINT "inventory_stock_entry_stockId_fkey" FOREIGN KEY ("stockId") REFERENCES "stock"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_history" ADD CONSTRAINT "inventory_history_manager_id_fkey" FOREIGN KEY ("manager_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_history" ADD CONSTRAINT "inventory_history_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice" ADD CONSTRAINT "invoice_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "pos"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice" ADD CONSTRAINT "invoice_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice" ADD CONSTRAINT "invoice_consigneeId_fkey" FOREIGN KEY ("consigneeId") REFERENCES "vendor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice" ADD CONSTRAINT "invoice_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_item" ADD CONSTRAINT "invoice_item_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "invoice"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_item" ADD CONSTRAINT "invoice_item_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "grn"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_item" ADD CONSTRAINT "invoice_item_grn_material_receipt_id_fkey" FOREIGN KEY ("grn_material_receipt_id") REFERENCES "grn_matrial_receipt"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tax_detail" ADD CONSTRAINT "tax_detail_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_amount_summary" ADD CONSTRAINT "invoice_amount_summary_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transport_detail" ADD CONSTRAINT "transport_detail_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "invoice_audit" ADD CONSTRAINT "invoice_audit_invoiceId_fkey" FOREIGN KEY ("invoiceId") REFERENCES "invoice"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "labour_attendance" ADD CONSTRAINT "labour_attendance_labour_id_fkey" FOREIGN KEY ("labour_id") REFERENCES "labours"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "labour_attendance" ADD CONSTRAINT "labour_attendance_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materials" ADD CONSTRAINT "materials_activityId_fkey" FOREIGN KEY ("activityId") REFERENCES "activities"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "materials" ADD CONSTRAINT "materials_unitId_fkey" FOREIGN KEY ("unitId") REFERENCES "units"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_grns" ADD CONSTRAINT "pr_grns_pr_id_fkey" FOREIGN KEY ("pr_id") REFERENCES "prs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_grns" ADD CONSTRAINT "pr_grns_created_by_id_fkey" FOREIGN KEY ("created_by_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_grn_material_receipt" ADD CONSTRAINT "pr_grn_material_receipt_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "pr_grns"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_grn_material_receipt" ADD CONSTRAINT "pr_grn_material_receipt_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_grn_files" ADD CONSTRAINT "pr_grn_files_grn_id_fkey" FOREIGN KEY ("grn_id") REFERENCES "pr_grns"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pr_grn_files" ADD CONSTRAINT "pr_grn_files_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_manager_id_fkey" FOREIGN KEY ("manager_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ham_specific_details" ADD CONSTRAINT "ham_specific_details_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "epc_specific_details" ADD CONSTRAINT "epc_specific_details_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bot_specific_details" ADD CONSTRAINT "bot_specific_details_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scopes" ADD CONSTRAINT "scopes_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "scopes" ADD CONSTRAINT "scopes_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "stock" ADD CONSTRAINT "stock_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_projects" ADD CONSTRAINT "contractor_projects_contractorId_fkey" FOREIGN KEY ("contractorId") REFERENCES "vendor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_projects" ADD CONSTRAINT "contractor_projects_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_files" ADD CONSTRAINT "contractor_files_contractorProjectId_fkey" FOREIGN KEY ("contractorProjectId") REFERENCES "contractor_projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contractor_files" ADD CONSTRAINT "contractor_files_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "files"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_bank_details" ADD CONSTRAINT "vendor_bank_details_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "vendor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_financial_details" ADD CONSTRAINT "vendor_financial_details_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "vendor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_other_details" ADD CONSTRAINT "vendor_other_details_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "vendor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_documents" ADD CONSTRAINT "vendor_documents_vendorId_fkey" FOREIGN KEY ("vendorId") REFERENCES "vendor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_documents" ADD CONSTRAINT "vendor_documents_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_supply_management" ADD CONSTRAINT "vendor_supply_management_vendor_id_fkey" FOREIGN KEY ("vendor_id") REFERENCES "vendor"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vendor_supply_management" ADD CONSTRAINT "vendor_supply_management_po_id_fkey" FOREIGN KEY ("po_id") REFERENCES "pos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "direct_supply_configuration" ADD CONSTRAINT "direct_supply_configuration_supply_id_fkey" FOREIGN KEY ("supply_id") REFERENCES "vendor_supply_management"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "direct_supply_configuration" ADD CONSTRAINT "direct_supply_configuration_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "inventory_supply_configuration" ADD CONSTRAINT "inventory_supply_configuration_supply_id_fkey" FOREIGN KEY ("supply_id") REFERENCES "vendor_supply_management"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionModules" ADD CONSTRAINT "_PermissionModules_A_fkey" FOREIGN KEY ("A") REFERENCES "modules"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PermissionModules" ADD CONSTRAINT "_PermissionModules_B_fkey" FOREIGN KEY ("B") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RolePermissions" ADD CONSTRAINT "_RolePermissions_A_fkey" FOREIGN KEY ("A") REFERENCES "permissions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_RolePermissions" ADD CONSTRAINT "_RolePermissions_B_fkey" FOREIGN KEY ("B") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
