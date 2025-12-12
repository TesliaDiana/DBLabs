/*
  Warnings:

  - You are about to drop the column `name` on the `CraftRecipe` table. All the data in the column will be lost.
  - The primary key for the `Item` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `item_id` on the `Item` table. All the data in the column will be lost.
  - Added the required column `recipe_name` to the `CraftRecipe` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "creaturedrop" DROP CONSTRAINT "creaturedrop_item_id_fkey";

-- DropForeignKey
ALTER TABLE "itemsinbiome" DROP CONSTRAINT "itemsinbiome_item_id_fkey";

-- DropForeignKey
ALTER TABLE "itemtoitemtype" DROP CONSTRAINT "itemtoitemtype_item_id_fkey";

-- DropForeignKey
ALTER TABLE "itemtypefood" DROP CONSTRAINT "itemtypefood_item_id_fkey";

-- DropForeignKey
ALTER TABLE "startitem" DROP CONSTRAINT "startitem_item_id_fkey";

-- DropIndex
DROP INDEX "CraftRecipe_name_key";

-- DropIndex
DROP INDEX "Item_recipe_id_key";

-- AlterTable
ALTER TABLE "CraftRecipe" DROP COLUMN "name",
ADD COLUMN     "recipe_name" TEXT NOT NULL,
ADD COLUMN     "station_required" INTEGER,
ALTER COLUMN "description" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Item" DROP CONSTRAINT "Item_pkey",
DROP COLUMN "item_id",
ADD COLUMN     "id" SERIAL NOT NULL,
ALTER COLUMN "item_name" SET DATA TYPE TEXT,
ALTER COLUMN "max_stack" SET DATA TYPE INTEGER,
ALTER COLUMN "durability" SET DATA TYPE INTEGER,
ADD CONSTRAINT "Item_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "itemtypefood" ADD CONSTRAINT "itemtypefood_pkey" PRIMARY KEY ("item_id", "food_characteristic");

-- AddForeignKey
ALTER TABLE "creaturedrop" ADD CONSTRAINT "creaturedrop_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "Item"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "itemsinbiome" ADD CONSTRAINT "itemsinbiome_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "Item"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "itemtoitemtype" ADD CONSTRAINT "itemtoitemtype_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "Item"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "itemtypefood" ADD CONSTRAINT "itemtypefood_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "Item"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "startitem" ADD CONSTRAINT "startitem_item_id_fkey" FOREIGN KEY ("item_id") REFERENCES "Item"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
