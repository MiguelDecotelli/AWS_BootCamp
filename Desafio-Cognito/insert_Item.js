var AWS = require('aws-sdk');
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
    
    let responseBody = "";
    let statusCode = 0;
    
    let {id, name} = JSON.parse(event.body);
    
    const params = {
      TableName : 'Languages',
      /* Item properties will depend on your application concerns */
      Item: {
         id: id,
         name: name
      }
    }
    
    try {
        
        await dynamodb.put(params).promise();
        statusCode = 200;
        responseBody = JSON.stringify('Linguagem inserida com sucesso!');
        
    } catch (err) {
          
        statusCode = 200;
        responseBody = JSON.stringify(err);
        
    }
      
    const response = {
        statusCode: statusCode,
        body: responseBody,
    };
    
    return response;
};