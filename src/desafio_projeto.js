"use strict";

const desafio_projeto = async (event) => {
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: "Desafio de Projeto Serverless DIO/AWS: Bem Vindo!",
        input: event,
      },
      null,
      2
    ),
  };
};

module.exports = {
  handler: desafio_projeto
}