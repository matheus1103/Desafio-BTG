-- CreateTable
CREATE TABLE "account_type" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR,
    "description" VARCHAR,

    CONSTRAINT "account_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts" (
    "id" SERIAL NOT NULL,
    "type_id" INTEGER,
    "balance" DOUBLE PRECISION,
    "created_at" TIMESTAMP(6),

    CONSTRAINT "accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer" (
    "id" SERIAL NOT NULL,
    "username" VARCHAR,
    "password" VARCHAR,
    "email" VARCHAR,
    "cpf" VARCHAR,
    "address" VARCHAR,
    "created_at" TIMESTAMP(6),
    "updated_at" TIMESTAMP(6),

    CONSTRAINT "customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_account" (
    "customer_id" INTEGER NOT NULL,
    "account_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(6),

    CONSTRAINT "customer_account_pkey" PRIMARY KEY ("customer_id","account_id")
);

-- CreateTable
CREATE TABLE "transaction_status" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR,
    "description" VARCHAR,

    CONSTRAINT "transaction_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "id" SERIAL NOT NULL,
    "type_id" INTEGER,
    "status_id" INTEGER,
    "account_id" INTEGER,
    "customer_id" INTEGER,
    "value" DOUBLE PRECISION,
    "created_at" TIMESTAMP(6),

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions_type" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR,
    "description" VARCHAR,

    CONSTRAINT "transactions_type_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "customer_cpf_email_key" ON "customer"("cpf", "email");

-- AddForeignKey
ALTER TABLE "accounts" ADD CONSTRAINT "accounts_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "account_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "customer_account" ADD CONSTRAINT "customer_account_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "accounts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "customer_account" ADD CONSTRAINT "customer_account_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_account_id_fkey" FOREIGN KEY ("account_id") REFERENCES "accounts"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "transaction_status"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "transactions_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

