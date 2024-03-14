const mongoose = require("mongoose");
const bcrypt = require('bcrypt');

const UserModelSchema = new mongoose.Schema({
  username: {
    type: String,
    unique:true,
    required: true,
  },
  email: {
    type: String,
    unique:true,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  dataRefObject: {
    type: mongoose.Types.ObjectId,
    required: true,
  },
});

UserModelSchema.pre("save", async function (next) {
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(this.password, salt);
  this.password = hashedPassword;
  next();
});

const UserModel = mongoose.model("User", UserModelSchema);
module.exports = UserModel;