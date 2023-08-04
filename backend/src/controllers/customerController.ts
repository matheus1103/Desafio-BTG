import { Request, Response } from "express";
import { prisma } from "../db";

export default {
    async createCustomer(request: Request, response: Response){
        try {
            const { username, password ,email , cpf, address} = request.body;
            // Checa se o cpf já existe
            const cpfExists = await prisma.customer.findFirst({ where: {cpf: cpf} });

            // Checa se o email já existe
            const emailExists = await prisma.customer.findFirst({ where: {email: email} });

            // Se cpf ou email já existirem, retorna um erro
            if (cpfExists || emailExists){
                return response.json({error: true, message: "Customer already exists"})
}
            if (!username || !password || !email || !cpf || !address) {
                return response.json({error: true, message: "All fields must be filled out"});
            }
            if (cpf.length !== 11) {
                return response.json({error: true, message: "The cpf must be 11 carachters long"});
            }
            const customer = await prisma.customer.create({
                data: {
                    username,
                    password,
                    email,
                    cpf,
                    address
                }
            });
            return response.json({error: false, message: "Customer created successfully", customer})

        }
        catch(error: any){
            return response.json({message: error.message})
        }
    },

    async updateCustomer(request: Request, response: Response){
        try {
            const { id, username, password, email, address } = request.body;

            // Verifica se o cliente existe
            const customerExists = await prisma.customer.findUnique({ where: { id: id } });
            // Checa se o email já existe
            // const emailExists = await prisma.customer.findFirst({ where: {email: email} });
            // if (emailExists){
            //     return response.json({error: true, message: "Customer email already used"})
            // }
            if (!customerExists){
                return response.status(400).json({error: true, message: "Customer does not exist"})
            }

            // Atualiza apenas os campos fornecidos
            const updateData: any = { updated_at: new Date() };
            if (username !== undefined) updateData.username = username;
            if (password !== undefined) updateData.password = password;
            if (email !== undefined) updateData.email = email;
            if (address !== undefined) updateData.address = address;

            const customer = await prisma.customer.update({
                where: { id: id },
                data: updateData
            });
            return response.json({error: false, message: "Customer updated successfully", customer})

        }
        catch(error: any){
            return response.status(422).json({message: "fail to update customer, email already used"})
        }
    },
    async getCustomer(request: Request, response: Response) {
        try {
            const { id } = request.params;
            const customer = await prisma.customer.findUnique({
                where: { id: Number(id) },
                include: {
                    customer_account: {
                        select: {
                            accounts: {
                                select: {
                                    account_number: true
                                }
                            }
                        }
                    }
                }
            });
            if (!customer) {
                return response.status(404).json({error: true, message: "Customer not found"});
            }
            return response.json(customer);
        } catch(error: any) {
            return response.status(500).json({message: error.message})
        }
    },

    async getCustomerTransactions(request: Request, response: Response){
        try {
            const { email, cpf } = request.body;
            const customer = await prisma.customer.findUnique({
                where: { cpf, email },
                include: {
                    transactions: {
                        include: {
                            transaction_status: true,
                            transactions_type: true
                        }
                    }
                }
            });

            if (!customer) {
                return response.status(404).json({error: true, message: "Customer not found"});
            }

            return response.json(customer.transactions);
        }
        catch(error: any){
            return response.status(500).json({message: error.message})
        }
    }
}
