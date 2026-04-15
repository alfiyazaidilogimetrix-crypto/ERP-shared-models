/*
  Warnings:

  - You are about to drop the column `branch_office_id` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `head_office_id` on the `users` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_branch_office_id_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_head_office_id_fkey";

-- AlterTable
ALTER TABLE "companies" ADD COLUMN     "file_id" INTEGER;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "branch_office_id",
DROP COLUMN "head_office_id";

-- CreateTable
CREATE TABLE "user_head_office" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "headOfficeId" INTEGER NOT NULL,

    CONSTRAINT "user_head_office_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_branch_office" (
    "id" SERIAL NOT NULL,
    "userHeadOfficeId" INTEGER NOT NULL,
    "branchOfficeId" INTEGER NOT NULL,

    CONSTRAINT "user_branch_office_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "companies" ADD CONSTRAINT "companies_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_head_office" ADD CONSTRAINT "user_head_office_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_head_office" ADD CONSTRAINT "user_head_office_headOfficeId_fkey" FOREIGN KEY ("headOfficeId") REFERENCES "head_office"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_branch_office" ADD CONSTRAINT "user_branch_office_userHeadOfficeId_fkey" FOREIGN KEY ("userHeadOfficeId") REFERENCES "user_head_office"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_branch_office" ADD CONSTRAINT "user_branch_office_branchOfficeId_fkey" FOREIGN KEY ("branchOfficeId") REFERENCES "branch_office"("id") ON DELETE CASCADE ON UPDATE CASCADE;
