-- DropForeignKey
ALTER TABLE "tender" DROP CONSTRAINT "tender_file_id_fkey";

-- AddForeignKey
ALTER TABLE "tender" ADD CONSTRAINT "tender_file_id_fkey" FOREIGN KEY ("file_id") REFERENCES "files"("id") ON DELETE CASCADE ON UPDATE CASCADE;
