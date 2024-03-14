const axios = require('axios');
require('dotenv').config()

const GPTModel = async (systemcontent, usercontent) => {
  const userQuestion = usercontent;
  try {
    const response = await axios.post(
      "https://api.openai.com/v1/chat/completions",
      {
        model: "gpt-3.5-turbo-0125",
        messages: [
          {
            role: "system",
            content: systemcontent,
          },
          { role: "user", content: userQuestion },
        ],
      },
      {
        headers: {
          Authorization: `Bearer ${process.env.OPENAI_API}`,
          "Content-Type": "application/json",
        },
      }
    );
    const generatedAnswer = response.data.choices[0].message.content;
    return generatedAnswer;
  } catch (error) {
    console.log("error",error);
    return error;
  }
};

module.exports = GPTModel;
