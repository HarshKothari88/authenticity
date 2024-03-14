const mongoose = require("mongoose");
const bcrypt = require('bcrypt');

const UserDataSchema = new mongoose.Schema({

  fullname: {
    type: String,
  },
  email: {
    type: String,
  },
  dob:{
    type: Date,
  },
  phonenumber:{
    type: String,
  }
});


const UserDataModel = mongoose.model("UserData", UserDataSchema);
module.exports = UserDataModel;