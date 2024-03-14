const jwt = require('jsonwebtoken');
const UserModel = require('../models/UserModel');

const verifyToken = async (req, res, next) => {
    const token = req.headers.authorization;
    if (!token) {
        return res.status(401).json({ message: "No token provided" });
    }

    try {
        const decoded = jwt.verify(token, 'jwt');
        const user = await UserModel.findOne({ dataRefObject: decoded.dataRefObject });
        if (!user) {
            return res.status(401).json({ message: "User not found" });
        }
        req.user = user;
        next(); 
    } catch (error) {
        return res.status(401).json({ message: error.message });
    }
};

module.exports = verifyToken;
