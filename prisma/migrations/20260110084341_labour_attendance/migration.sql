-- CreateEnum
CREATE TYPE "AttendanceStatus" AS ENUM ('PRESENT', 'ABSENT', 'HALF_DAY', 'ON_LEAVE');

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

-- CreateIndex
CREATE INDEX "LabourAttendance_labour_id_date_idx" ON "LabourAttendance"("labour_id", "date");

-- CreateIndex
CREATE INDEX "LabourAttendance_project_id_idx" ON "LabourAttendance"("project_id");

-- AddForeignKey
ALTER TABLE "LabourAttendance" ADD CONSTRAINT "LabourAttendance_labour_id_fkey" FOREIGN KEY ("labour_id") REFERENCES "Labour"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabourAttendance" ADD CONSTRAINT "LabourAttendance_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
