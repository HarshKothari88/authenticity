require("dotenv").config();
const { Error } = require("mongoose");
const GPTModel = require("./GPT");

const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI(process.env.GEMNI_API);

async function GemniModel(systemcontent, usercontent) {
  var flag = 1;
  var count = 0;
  while (flag) {
    try {
      const data = systemcontent + usercontent;
      const model = genAI.getGenerativeModel({ model: "gemini-pro" });
      const prompt = data;

      const result = await model.generateContent(prompt);
      const response =  result.response;
      const text = response.text();
      return text;

    } catch (err) {
      console.log("trying");
      count++;
      if (count >= 2) {
        const result = await GPTModel(systemcontent, usercontent)
        return result
      }
      await sleep(3000);
    
    }
  }
}

function extractJsonData(text) {
  const startIndex = text.indexOf("{");
  const endIndex = text.lastIndexOf("}");
  const jsonData = text.substring(startIndex, endIndex + 1);
  return jsonData;
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

module.exports = GemniModel;
