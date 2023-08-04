import { Request, Response } from "express";
import { prisma } from "../db";

export default {
    async createAccount(request: Request, response: Response){
        try {
            const { cpf, type_id, balance } = request.body;

            // Verifica se o cliente existe
            const customerExists = await prisma.customer.findUnique({ where: { cpf } });

            if (!customerExists){
                return response.status(400).json({error: true, message: "Customer does not exist"})
            }

            // Verifica se o tipo de conta é válido
            const accountTypeExists = await prisma.account_type.findUnique({ where: { id: type_id } });

            if (!accountTypeExists){
                return response.status(400).json({error: true, message: "Account type does not exist"})
            }

            const customerAccountExists = await prisma.accounts.findFirst({
                where: {
                    type_id: type_id
                },
                select: {
                    customer_account:{
                        where: { customer_id: customerExists.id }
                    }
                }
            });

            if (customerAccountExists){
                return response.status(400).json({error: true, message: "Customer already has this account type"})
            }
            // Cria a conta
            const account = await prisma.accounts.create({
                data: {
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

            return response.json({error: false, message: "Account created successfully", account})

        }
        catch(error: any){
            return response.status(500).json({message: error.message})
        }
    }
    // async updateAccount(request: Request, response: Response){
    //     try {
    //         const { id, balance } = request.body;

}
