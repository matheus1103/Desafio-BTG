/*
  Warnings:

  - Made the column `balance` on table `accounts` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "accounts" ALTER COLUMN "balance" SET NOT NULL;
