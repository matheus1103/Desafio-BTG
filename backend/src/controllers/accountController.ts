import { Request, Response } from "express";
import { prisma } from "../db";

export default {
    async createAccount(request: Request, response: Response){
        try {
            const { cpf, type_id, balance } = request.body;
            const randomNumber = Math.floor(100000 + Math.random() * 900000);
            const randomString = randomNumber.toString();

            // Verifica se o cliente existe
            const customerExists = await prisma.customer.findUnique({ where: { cpf } });

            if (!customerExists){
                return response.status(400).json({error: true, message: "Customer does not exist"})
            }
            async function checkAccountNumber(randomString: string){
                const accountExists = await prisma.accounts.findFirst({
                    where: {
                        account_number: randomString
                    }
                });
                if (!accountExists){
                    return randomString
                }
                else {
                    const randomString = randomNumber.toString();
                    checkAccountNumber(randomString)
                }
            }
            const account_number = await checkAccountNumber(randomString);
            // Verifica se o tipo de conta é válido
            const accountTypeExists = await prisma.account_type.findUnique({ where: { id: type_id } });

            if (!accountTypeExists){
                return response.status(400).json({error: true, message: "Account type does not exist"})
            }
            const customerAccountExists = await prisma.customer_account.findFirst({
                where: {
                    customer_id: customerExists.id,
                    accounts: {
                        type_id: type_id
                    }
                },
                include: {
                    accounts: true
                }
            });

            if (customerAccountExists){
                return response.status(400).json({error: true, message: "Account with this type already exists for this customer"})
            }
            // Cria a conta
            const account = await prisma.accounts.create({
                data: {
                    account_number: account_number,
                    type_id: type_id,
                    balance: balance,
                    created_at: new Date()
                }
            });
            await prisma.customer_account.create({
                data: {
                    customer_id: customerExists.id,
                    account_id: account.id
                }
            })
            if(account && account.balance > 0) {
                // Cria a nova transação
                const transaction = await prisma.transactions.create({
                    data: {
                        account_id: account.id,
                        customer_id: customerExists.id,
                        // depósito
                        transaction_type_id: 2,
                        value: balance,
                        // transação em processamento
                        status_id: 3
                    }
                });
                return response.json({ account, transaction });
            }
            return response.json({error: false, message: "Account created successfully", account})

        }
        catch(error: any){
            return response.status(500).json({message: error.message})
        }
    },
    async updateAccount(request: Request, response: Response) {
        try {
            const { account_number, cpf } = request.body;

            // Verificar se account_number e cpf foram fornecidos
            if (!account_number || !cpf) {
                return response.status(400).json({error: true, message: "account_number and cpf must be provided"});
            }

            // Verifica se o cliente e a conta existem
            const customer = await prisma.customer.findUnique({ where: { cpf: cpf } });
            const account = await prisma.accounts.findUnique({ where: { account_number: account_number } });

            if (!customer || !account) {
                return response.status(400).json({error: true, message: "Customer or account does not exist"});
            }

            // Verifica se o cliente já está associado à conta
            const associationExists = await prisma.customer_account.findUnique({
                where: {
                    customer_id_account_id: {
                        customer_id: customer.id,
                        account_id: account.id
                    }
                }
            });

            if (associationExists) {
                return response.status(400).json({error: true, message: "Customer is already associated with this account"});
            }

            // Adiciona o cliente à conta
            await prisma.customer_account.create({
                data: {
                    customer_id: customer.id,
                    account_id: account.id
                }
            });

            return response.json({error: false, message: "Customer successfully added to the account"});

        } catch(error: any) {
            return response.status(500).json({message: error.message});
        }
    },
    async getAccount(request: Request, response: Response) {
        try {
            const { account_number, cpf } = request.body;

            // Obter o cliente com base no CPF fornecido
            const customer = await prisma.customer.findUnique({
                where: { cpf },
            });

            // Se o cliente não for encontrado, retorne um erro
            if (!customer) {
                return response.status(404).json({ error: true, message: "Customer not found" });
            }

            // Encontrar a primeira conta que corresponda ao número da conta fornecido e que esteja associada ao cliente encontrado
            const account = await prisma.accounts.findFirst({
                where: {
                    account_number,
                    customer_account: {
                        some: {
                            customer_id: customer.id,
                        },
                    },
                },include: {
                    account_type: true, // Aqui estamos incluindo os dados do account_type na resposta
                },
            });

            // Se a conta não for encontrada, retorne um erro
            if (!account) {
                return response.status(404).json({ error: true, message: "Account not found" });
            }

            return response.json(account);
        } catch (error: any) {
            return response.status(500).json({ message: error.message });
        }
    }


}
