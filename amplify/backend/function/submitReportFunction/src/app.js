const express = require('express');
const bodyParser = require('body-parser');
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
const AWS = require('aws-sdk');
const { v4: uuidv4 } = require('uuid');

// Initialize DynamoDB
const dynamoDB = new AWS.DynamoDB.DocumentClient();
const TABLE_NAME = 'HelpNowReports'; // ✅ Replace with your actual DynamoDB table name

const app = express();
app.use(bodyParser.json());
app.use(awsServerlessExpressMiddleware.eventContext());

// Enable CORS
app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "*");
  next();
});

// POST /submitReport → Save report data
app.post('/submitReport', async function (req, res) {
  try {
    const {
      userId,
      title,
      description,
      imageUrl,
      timestamp
    } = req.body;

    if (!userId || !title || !description) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const reportId = uuidv4();
    const reportItem = {
      reportId,
      userId,
      title,
      description,
      imageUrl: imageUrl || null,
      timestamp: timestamp || new Date().toISOString(),
      status: 'Pending' // Default status
    };

    await dynamoDB.put({
      TableName: TABLE_NAME,
      Item: reportItem
    }).promise();

    res.json({ success: true, message: 'Report submitted successfully', reportId });
  } catch (error) {
    console.error('Error submitting report:', error);
    res.status(500).json({ error: 'Failed to submit report' });
  }
});

// Other methods (optional stubs)
app.get('/submitReport', function (req, res) {
  res.json({ message: 'GET not supported on /submitReport' });
});

app.listen(3000, function () {
  console.log("App started");
});

module.exports = app;
