-- CreateTable
CREATE TABLE "project_category" (
    "id" SERIAL NOT NULL,
    "project_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,

    CONSTRAINT "project_category_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "project_category" ADD CONSTRAINT "project_category_project_id_fkey" FOREIGN KEY ("project_id") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project_category" ADD CONSTRAINT "project_category_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE CASCADE ON UPDATE CASCADE;
