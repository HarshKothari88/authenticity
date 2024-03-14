const jwt = require('jsonwebtoken');
const UserModel = require("../../models/UserModel");
const UserDataModel = require("../../models/UserData");

const Register = async (req, res, next) => {
  const { username, email, password } = req.body;

  try {
    const existingUser = await UserModel.findOne({ username: username });
    if (existingUser) {
      return res.status(400).json({ message: "Username already exists" });
    }

    const checkemail = await UserModel.findOne({ email: email });
    if (checkemail) {
      return res.status(400).json({ message: "Email already exists" });
    }

    const UserData = new UserDataModel({ email: email });
    await UserData.save();

    // Create a new user instance
    const user = new UserModel({
      username: username,
      email: email,
      password: password,
      dataRefObject: UserData._id, // Assuming this is provided externally
    });

    // Save the user to the database
    await user.save();

    const token = jwt.sign({ dataRefObject: UserData._id }, "jwt", {
      expiresIn: "30d",
    });

    // Respond with success message
    res.status(201).json({
      staus: 201,
      message: "User registered successfully",
      token: token,
      dataRefObject: user.dataRefObject,
    });
  } catch (error) {
    // If any error occurs, send a 400 response with the error message
    res.status(400).json({
      status: 400,
      message: error.message,
    });
  }
};

module.exports = Register;
