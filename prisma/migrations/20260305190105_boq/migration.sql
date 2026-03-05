-- CreateTable
CREATE TABLE "material_boq" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "material_boq_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "material_boq_item" (
    "id" SERIAL NOT NULL,
    "material_boq_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "activity_id" INTEGER NOT NULL,
    "category" TEXT NOT NULL,
    "scope_quantity" DOUBLE PRECISION,
    "purchased_quantity" DOUBLE PRECISION,
    "balanced_quantity" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "material_boq_item_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workscope" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "workscope_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "workscope_item" (
    "id" SERIAL NOT NULL,
    "workscope_id" INTEGER NOT NULL,
    "material_id" INTEGER NOT NULL,
    "unit_id" INTEGER NOT NULL,
    "activity_id" INTEGER NOT NULL,
    "category" TEXT NOT NULL,
    "length" INTEGER,
    "executed" DOUBLE PRECISION,
    "quantity" DOUBLE PRECISION,
    "balanced" DOUBLE PRECISION,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "workscope_item_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "material_boq" ADD CONSTRAINT "material_boq_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_boq_item" ADD CONSTRAINT "material_boq_item_material_boq_id_fkey" FOREIGN KEY ("material_boq_id") REFERENCES "material_boq"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_boq_item" ADD CONSTRAINT "material_boq_item_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_boq_item" ADD CONSTRAINT "material_boq_item_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "material_boq_item" ADD CONSTRAINT "material_boq_item_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workscope" ADD CONSTRAINT "workscope_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workscope_item" ADD CONSTRAINT "workscope_item_workscope_id_fkey" FOREIGN KEY ("workscope_id") REFERENCES "workscope"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workscope_item" ADD CONSTRAINT "workscope_item_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "materials"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workscope_item" ADD CONSTRAINT "workscope_item_unit_id_fkey" FOREIGN KEY ("unit_id") REFERENCES "units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "workscope_item" ADD CONSTRAINT "workscope_item_activity_id_fkey" FOREIGN KEY ("activity_id") REFERENCES "activities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
