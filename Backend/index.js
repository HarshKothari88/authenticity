const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const http = require('http');
const path = require('path');
const morgan = require('morgan')
const socketIO = require('socket.io');
require('dotenv').config()

// ROUTES #################################################################
const Auth = require('./routes/Auth')

// UTILS ##################################################################
const Gemni = require('./utils/Gemni')

const PORT = 80;
const MONGO_URI = 'mongodb://localhost:27017/Authentify';

const app = express();

app.use(cors())
app.use(bodyParser.json())
app.use(morgan('dev'))


const server = http.createServer(app);
const socketSetup = require('./utils/socket');

app.get('/client', (req, res) => {
    res.sendFile(path.join(__dirname, '/public/index.html'));
});

app.get('/', (req, res) => {
    const message = {
        message: 'Authentify API HOME',
        status: 200,
        timestamp: new Date().toISOString(),
        routes:['/api/auth/login',"/api/auth/register"]
    }
  res.status(200).json(message);
});

app.use("/api/auth",Auth)



const connectToDB = async() =>{
    try {
        await mongoose.connect(process.env.MONGO_ATLAS ||  'mongodb://localhost:27017/Authentify',{
        })
        .then(
            server.listen(process.env.PORT || 80 ,()=>{
                console.log(`Authentify API is running on : http://localhost:${process.env.PORT}`)
            }
        ))
        .then(console.log('MongoDB Connected'))
        socketSetup(server)
    } catch (error) {
        console.log(error.message)
        process.exit(1)
    }
}
connectToDB()