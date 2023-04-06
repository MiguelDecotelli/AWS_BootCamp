"use strict";

const AWS = require("aws-sdk")

const updateItem = async (event) => {

  const {itemStatus} = event.body;
  const {id} = event.pathParameters

  const dynamodb = new AWS.DynamoDB.DocumentClient();

  await dynamodb.update({
    TableName: "Linguagens",
    Key: {id},
    UpdateExpression: 'set itemStatus = :itemStatus',
    ExpressionAttributeValues: {
      ':itemStatus': itemStatus
    },
    ReturnValues: "ALL_NEW"
  }).promise()

  return {
    statusCode: 200,
    body: JSON.stringify(
      { msg: 'Item updated'}
    ),
  };
};


module.exports = {
    handler:updateItem
}

