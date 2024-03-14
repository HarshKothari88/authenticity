const UserModel = require('../../models/UserModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const Login = async (req, res, next) => {
    const { email, password } = req.body;

    try {
        // Find user by email
        const user = await UserModel.findOne({ email: email });
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        // Check if password matches
        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            return res.status(401).json({ message: "Invalid password" });
        }

        // Create and sign JWT token
        const token = jwt.sign({ dataRefObject: user.dataRefObject }, 'jwt', { expiresIn: '30d' });

        // Respond with success message and token
        res.status(200).json({
            status: 200,
            message: "Login successful",
            token: token,
            dataRefObject:user.dataRefObject
        });
    } catch (error) {
        // If any error occurs, send a 500 response with the error message
        res.status(500).json({
            status: 500,
            message: error.message
        });
    }
};

module.exports = Login;
