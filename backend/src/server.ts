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
app.post('/createCustomer', customerController.createCustomer);
app.post('/updateCustomer', customerController.updateCustomer);
app.post('/createAccount', accountController.createAccount);
app.post('/createTransaction', transactionController.createTransaction);


app.use(route)
app.listen(3333, () => console.log('server running on port 3333'))