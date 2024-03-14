const socketIO = require("socket.io");
const GemniModel = require("../utils/Gemni");

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

module.exports = (server) => {
  const io = socketIO(server);

  io.on("connection", (socket) => {
    let userID;
    let language;
    let FullName;
    console.log("A user connected: ", socket.id);

    var msg = {
      section: 0,
      message:
        "Greetings! I'm Authentify. Please specify your preferred language.",
    };

    socket.on("init", async (id) => {
      console.log("User initialized with ID:", id);
      userID = id;
      socket.emit("backend", msg);
      console.log("emitted language");
    });

    const getGPTFUNC = async (systemcontent, usercontent) => {
      GPTdata = await GemniModel(systemcontent, usercontent);
      return GPTdata;
    };

    socket.on("clientside", async (data) => {
      var GPTdata;
      console.log("Received Language ", data);
      language = data.language || "hindi";
      const section = data.section;
      const message = data.message;
      switch (section) {
        // #######################################################################
        case 0:
          var systemcontent =
            "Need to translate the language to : " +
            message +
            "Translate the below Line.";
          var usercontent =
            "Hello, I am Authentify. I am here to help you with your KYC process. Please provide your full name. 📝👤";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 1,
            message: GPTdata,
          };
          console.log(msg);
          socket.emit("backend", msg);
          break;

        // #######################################################################
        // NAME
        case 1:
          var systemcontent =
            "Need to extract the user fullname from the text given below, i only need the name itself, retun me string as the fullname";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("FULL NAME", GPTdata);
          FullName = GPTdata;

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Hello.!" + FullName;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 2,
            message: GPTdata,
          };
          socket.emit("backend", msg);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please provide your date of birth 🎂";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 2,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // #######################################################################
        case 2:
          var systemcontent =
            "Need to extract the date of birth from the text given below, i only need the date of bith itself, retun me a string with date month and year . No other text should be there only the date of birth";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("dob", GPTdata);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please provide your nationality 🌍👤";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 3,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // NATIONALITY
        case 3:
          var systemcontent =
            "Need to extract the nationality from the text given below, i only need the nationality itself, retun me a string with the nationality";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("nationality : ", GPTdata);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please input your PAN card number.";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 4,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // PAN #######################################################################
        case 4:
          var systemcontent =
            "Need to extract the PAN Card Number from the text given below, i only need the PAN Card Number itself, retun me a string with the PAN Card Number";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("PAN Card Number : ", GPTdata);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please provide your Aadhaar card number. 📄";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 5,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // AADHAR #######################################################################
        case 5:
          var systemcontent =
            "Need to extract the AADHAR Card Number from the text given below, i only need the AADHAR Card Number itself, retun me a string with the AADHAR Card Number";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("AADHAR Card Number : ", GPTdata);

          var systemcontent =
            "Need to translate just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please provide your address 🏠.";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 6,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // Address #######################################################################
        case 6:
          var systemcontent =
            "Need to extract the Address  from the text given below, i only need the  Address itself, retun me a string with the  Address";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("Address : ", GPTdata);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please provide your phone number 📞";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 7,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // PHONE #######################################################################
        case 7:
          var systemcontent =
            "Need to extract the Phone Number from the text given below, i only need the Phone Number itself, retun me a string with the Phone Number";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("Phone Number : ", GPTdata);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please indicate your income range 😊 ";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 8,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // Income #######################################################################
        case 8:
          var systemcontent =
            "Need to extract the Income Range from the text given below, i only need the Income Range itself, retun me a string with the income range";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("Income Range : ", GPTdata);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please provide your current job title 🌟✨";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 9,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // Employability #######################################################################
        case 9:
          var systemcontent =
            "Need to extract the Employability Role Position from the text given below, i only need the Status Position itself, retun me a string with Role";
          var usercontent = message;
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("Employability Role : ", GPTdata);
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Almost Done..! \nNow Some Photo Shoot Time 🤳📷";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 10,
            message: GPTdata,
          };
          socket.emit("backend", msg);

          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent =
            "Could you please provide a live photo of yourself? 📸";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 10,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        // Live Photo #######################################################################
        case 10:
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Live Photograph received";
          // GPTdata = await getGPTFUNC(systemcontent, usercontent);
          // console.log("Live Photo Recv : ", GPTdata);
          GPTdata = "Live Photograph received";
          console.log("Live Photo");
          msg = {
            section: 11,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          GPTdata = "Photo Matching Started.!";
          console.log(GPTdata);
          msg = {
            section: 11,
            message: GPTdata,
          };
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent =
            "Could you please provide a photo of your Aadhar card? 📸";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("Aadhar Photo Graph : ", GPTdata);
          msg = {
            section: 11,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        case 11:
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Aadhar Card Photograh received";
          // GPTdata = await getGPTFUNC(systemcontent, usercontent);
          // console.log("Aadhr Photo Graph : ", GPTdata);
          GPTdata = "AadhrPhoto Graph Received";
          console.log("Aadhar Photo");
          msg = {
            section: 12,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          GPTdata = "Photo Matching Started.!";
          console.log(GPTdata);
          msg = {
            section: 11,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          await sleep(3000);
          GPTdata = "Aadhar Photo Matched Successfully.!";
          console.log("Live Photo");
          msg = {
            section: 11,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent =
            "Could you please provide a photo of your PAN card? 📸";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("PAN Photo Graph : ", GPTdata);
          msg = {
            section: 12,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        case 12:
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "PAN Card Photo received";
          // GPTdata = await getGPTFUNC(systemcontent, usercontent);
          // console.log("PAN Photo Recv : ", GPTdata);
          GPTdata = "PAN PHOTO RECEIVED";
          console.log("PAN Image");
          msg = {
            section: 13,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          GPTdata = "Photo Matching Started.!"
          console.log(GPTdata)
          msg={
            section:11,
            message:GPTdata
          }
          socket.emit("backend",msg)
          await sleep(4000);
          GPTdata = "PAN Details Matched Successfully.!"
          console.log("PAN Photo")
          msg={
            section:11,
            message:GPTdata
          }
          socket.emit("backend",msg)
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Please share a photo of your signature 📷🖋️";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          console.log("Signature Photo Graph : ", GPTdata);
          msg = {
            section: 13,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          break;

        case 13:
          var systemcontent =
            "Need to transalte just the language to : " +
            language +
            "Translate the below Line.";
          var usercontent = "Signature Photo received";
          // GPTdata = await getGPTFUNC(systemcontent, usercontent);
          // console.log("Signature Photo Recv : ", GPTdata);
          GPTdata = "Signature Photo received";
          console.log("Signature Photo");
          msg = {
            section: 14,
            message: GPTdata,
          };
          socket.emit("backend", msg);

          var usercontent =
            "Thank you for uploading all the details and data! 🙌";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 14,
            message: GPTdata,
          };
          socket.emit("backend", msg);
          var usercontent =
            "We'll be in touch shortly! 😊 As soon as possible \nTHANKYOU 🙏🙏🙏";
          GPTdata = await getGPTFUNC(systemcontent, usercontent);
          msg = {
            section: 14,
            message: GPTdata,
            success: true,
          };
          socket.emit("backend", msg);
          break;
      }
    });

    // Handle disconnection
    socket.on("disconnect", () => {
      console.log("User disconnected");
    });
  });
};
