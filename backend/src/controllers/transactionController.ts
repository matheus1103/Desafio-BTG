import { Request, Response } from "express";
import { prisma } from "../db";

export default {
    async createTransaction(request: Request, response: Response){
        try {
            const { account_id, customer_id, transaction_type_id, status_id, value } = request.body;

            // Verifica se a associação já existe
            const account = await prisma.accounts.findFirst({

                select: {
                    customer_account:{
                        where: { customer_id: customer_id, account_id: account_id }
                    },
                    balance: true
                }
            });

            if (!account){
                return response.json({error: true, message: "We couldn't this customer/account association"})
            }
            if (transaction_type_id === 1){

                if (account?.balance < value){
                    return response.json({error: true, message: "Insufficient funds"})
                }
                await prisma.accounts.update({
                    where: { id: account_id },
                    data: {
                        balance: account.balance - value
                    }
                })

            } else if (transaction_type_id === 2){
                    await prisma.accounts.update({
                        where: { id: account_id },
                        data: {
                            balance: account.balance + value
                        }
                    })
            }
            const transaction = await prisma.transactions.create({
                data: {
                    account_id: account_id,
                    customer_id: customer_id,
                    transaction_type_id: transaction_type_id,
                    status_id: status_id,
                    value: value,
                    created_at: new Date()
                }
            });
            return response.json({error: false, message: "Transaction created successfully", transaction})
        }
        catch(error: any){
            return response.json({message: error.message})
        }
    }
}
