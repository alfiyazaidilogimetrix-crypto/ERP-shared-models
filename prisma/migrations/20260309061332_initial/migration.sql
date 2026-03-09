/*
  Warnings:

  - You are about to drop the `project_scopes` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `scopes` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "project_scopes" DROP CONSTRAINT "project_scopes_activity_id_fkey";

-- DropForeignKey
ALTER TABLE "project_scopes" DROP CONSTRAINT "project_scopes_scope_id_fkey";

-- DropForeignKey
ALTER TABLE "project_scopes" DROP CONSTRAINT "project_scopes_unit_id_fkey";

-- DropForeignKey
ALTER TABLE "scopes" DROP CONSTRAINT "scopes_project_id_fkey";

-- DropTable
DROP TABLE "project_scopes";

-- DropTable
DROP TABLE "scopes";
