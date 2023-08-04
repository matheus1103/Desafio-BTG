import express from 'express'

import { Router, Request, Response } from 'express';
import customerController from './controllers/customerController';
import accountController from './controllers/accountController';
import transactionController from './controllers/transactionController';

const app = express();

const route = Router()

app.use(express.json())

route.get('/', (req: Request, res: Response) => {
  res.json({ message: 'hello world with Typescript' })
})
app.post('/create-customer', customerController.createCustomer);
app.post('/create-account', accountController.createAccount);
app.post('/create-transaction', transactionController.createTransaction);

app.put('/update-customer', customerController.updateCustomer);
app.put('/update-account', accountController.updateAccount);

app.get("/customer/:id", customerController.getCustomer);
app.get("/customer-transactions", customerController.getCustomerTransactions);
app.get("/account", accountController.getAccount);

app.use(route)
app.listen(3333, () => console.log('server running on port 3333'))