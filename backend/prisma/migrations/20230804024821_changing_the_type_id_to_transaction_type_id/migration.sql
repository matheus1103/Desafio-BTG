/*
  Warnings:

  - You are about to drop the column `type_id` on the `transactions` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_type_id_fkey";

-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "type_id",
ADD COLUMN     "transaction_type_id" INTEGER,
ALTER COLUMN "status_id" SET DEFAULT 1;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_transaction_type_id_fkey" FOREIGN KEY ("transaction_type_id") REFERENCES "transactions_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
