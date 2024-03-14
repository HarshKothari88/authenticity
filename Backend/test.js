const GemniModel = require("./utils/Gemni")
const GPTModel = require("./utils/GPT")


const systemcontent = "Need to extract the user fullname from the text given below, i only need the name itself, retun me a json with first and lastname the keys name should be 'firstname' and 'lastname'";
const usercontent = "Hey good morining. How are you, My name is Bishal Kumkar De";

GemniModel(systemcontent, usercontent)
  .then(result => {
    console.log(result);
  })
  .catch(error => {
    console.error("Error:", error);
  });
