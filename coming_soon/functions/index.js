const functions = require("firebase-functions");

const cors = require("cors")({origin: true});

exports.test = functions.https.onRequest((request, response) => {
  cors(request, response, () => {
    response.status(500).send({test: "Testing functions"});
  });
});

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
