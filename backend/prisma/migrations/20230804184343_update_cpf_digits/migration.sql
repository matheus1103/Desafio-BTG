/*
  Warnings:

  - You are about to alter the column `cpf` on the `customer` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(11)`.

*/
-- AlterTable
ALTER TABLE "customer" ALTER COLUMN "cpf" SET DATA TYPE VARCHAR(11);
