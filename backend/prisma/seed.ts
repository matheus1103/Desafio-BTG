import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  // Inserir dados na tabela account_type
  const accountType1 = await prisma.account_type.create({
    data: {
      name: 'Conta Poupança',
      description: 'Conta poupança para guardar economias',
    },
  })
  const accountType2 = await prisma.account_type.create({
    data: {
      name: 'Conta Corrente',
      description: 'Conta corrente para movimentações diárias',
    },
  })

  // Inserir dados na tabela transactions_type
  const transactionType1 = await prisma.transactions_type.create({
    data: {
      name: 'Saque',
      description: 'Depósito em conta',
    },
  })

  const transactionType2 = await prisma.transactions_type.create({
    data: {
      name: 'Depósito',
      description: 'Retirada de conta',
    },
  })

  // Inserir dados na tabela transactions_status
  const transactionStatus1 = await prisma.transaction_status.create({
    data: {
      name: 'Concluída',
      description: 'Transação concluída',
    },
  })

  const transactionStatus2 = await prisma.transaction_status.create({
    data: {
      name: 'Falha',
      description: 'Transação Falhou',
    },
  })

  const transactionStatus3 = await prisma.transaction_status.create({
    data: {
      name: 'Pendente',
      description: 'Transação pendente',
    },
  })
}

main()
  .catch((e) => {
    throw e
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
