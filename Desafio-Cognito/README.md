# DESAFIO DE PROJETO DIO AWS

## Utilização da autenticação do Amazon Cognito para inserção em tabela Dynamo com função Lambda

### Serviços utilizados / Etapas de criação:
Amazon API Gateway
Amazon DynamoDB
Amazon Lambda
Amazon Cognito
Postman

### Criação de API REST no API Gateway:
Ao abrir o "Dashboard" selecionar a opção de criar uma API, escolher a opção "REST API" (não privada) e clicar em "BUILD".
Manter todas as opções como padrão e selecionar apenas o nome de sua API [Desafio_Projeto_DIO_AWS].
Uma vez criada, selecionar a opção lateral "Resources" e em seguida, em "Actions", selecionar "Create Resource", escolher o nome [items] e criar sua "Resource.

### Criação de tabela DynamoDB:
Ao abrir a "Dashboard" da DynamoDB, procurar a opção "Create Table", definir o nome [Languages], a partition key [id] e clicar em "Create Table".
EM "Overview", procurar por "Additional info" a salvar a "Amazon Resource Name" - ARN para uso posterior.

### Criação de função AWS Lambda para inserção de items:
Ao abrir a "Dashboard" Lambda, selecionar a opção "Create Function" [Desafio_Projeto_DIO_AWS], selecionar o "Runtime" [Node.js 14.x] e criar sua função.
No painel da função criada, em "Code source", utilizar o código anexo [insert_Item.js], podendo alterar o nome e clicar em deploy para salvar o código.
No Meu acima do código, selecionar "Configuration", "Permissions" no menu lateral e em "Execution Role", clicar em "Role name".

### IAM Management Console:
No "Dashboard" IAM procurar a opção "Add permissions" e selecionar a opção "Create inline policy".
Selecionar o "Service" [DynamoDB], a "Action" [PutItem] e em "Resources", clicar na "ARN" e utilizar a que foi salva anteriormente dentro da tabela, no campo "Specify ARN for Table" e clicar em "Review Policy". Aqui, definir o nome da "Policy" [Desafio_Projeto_DIO_AWS] e clicar em "Create Policy".

### Integrando API Gateway com Lambda Function:
No "Dashboard", selecionar a API [Desafio_Projeto_DIO_AWS] e em "Resources", após selecionar a "Resource" criada [items], no menu "Actions" escolher a opção "Create Method" [POST]. Dentro da seção, marcar a opção "Use Lambda Proxy Integration", confirmar a região [sa-east-1] e adicionar o nome da função lambda [Desafio_Projeto_DIO_AWS] e clicar em "Save".
Selecionar novamente o menu "Actions", mas desta vez clicar em "Deploy API". Na opção "Deployment Stage", selecionar "New Stage" [development] e clicar em "Deploy". Será gerado um "Endpoint" para utilização no "Postman".

### Fazendo Requests no Postman:
No Postman, "Create a New Collection" [Desafio-Projeto-DIO-AWS]. Uma vez criada a nova coleção, adicionar (Add Request) "Method POST" [Post_Language] e "Method GET" [Login_Cognito] (A ser utilizado posteriormente). Colar o "Endpoint" da API na barra de endereço.
Dentro de [Post_Language], procurar pela opção "Body", selecionar a opção "Raw" e, na opção "Text", utilizar "JSON"
Como Teste, incluir um item na DynamoDB [Languages] e slicar em "Send":
{
  "id": "01",
  "name": "JavaScript"
}

### Criando User Pool no Amazon Cognito - Create User Pool:
- Step 1 -> Cognito User Pool sign-in Options: [Email] ou selecionar opção de sua preferência.
- Step 2 -> Password Policy / Multi-Factor-authentication / User account recovery - Selecionar opções de sua preferência.
- Step 3 -> Self-Service sign up / Attribute verification and user account confirmation / Verifying attribute changes / Required attributes [Name] - Selecionar opções de sua preferência.
- Step 4 -> Configure message delivery -> E-mail: "Send email with Cognito"
- Step 5 -> User Pool Name: [Desafio-Projeto-DIO-AWS] / Hosted authentication pages: "Use the cognito hosted UI" / Domain: "Use a cognito domain" -> [desafio-projeto] / Initial app client: "Public Client" - App client name: [DIO-AWS-ClientApp] / Allowed callback URLs: [https://example.com/logout].
Step 6 -> Review & create.

### APP Integration:
Dentro de "User pool", procurar pela opção "App integration" e ao final da página selecionar "App client name" [DIO-AWS-ClientApp]. Salve o client ID para utilizá-lo nas configurações do Cognito no Postman. Agora procurar pela opção "Hosted UI" e selecionar "Edit". 
Na opção "OAuth 2.0" marcar "Authorization code grant" e "Implicit grant".
Na opção "OpenID Connect scopes" marcar "Email" e "OpenID".
Salvar alterações.

### Criando autorização no Amazon API Gateway para o Amazon Cognito na API REST.
Dentro da "Dashboard" da API [Desafio_Projeto_DIO_AWS] selecionar "Authorizers" e clicar em "Create New Authorizer".
Definir um nome [Desafio_Projeto_DIO_AWS_Cognito], marcar a opção "Cognito", adicionar o nome da User Pool [Desafio-Projeto-DIO-AWS] em "Cognito User Pool" e definir o "Token Source" como "Authorization" e criar.
Agora em "Resources", após selecionar "POST", em "method Request", definir "Authorization" como [Desafio_Projeto_DIO_AWS_Cognito] e efetivar as alterações selecionando "Deploy".

### Adicionando Autorização na Request do Postman
Agora no "method GET" criado anteriormente [Login_Cognito], na aba de "Authorization", fazer as seguintes alterações:
- Type -> OAuth 2.0
- Callback URL -> [https://example.com/logout]
- Auth URL -> [https://desafio-projeto.auth.sa-east-1.amazoncognito.com/login]
- Client ID - [ClientID]
- Scope -> [email e openid]
- Client Authentication -> [Send client credentials in body]
- Selecionar "Get New Acces Token"

Após criar um login de usuário, confirmar o e-mail, será criado um Token de accesso: "Bearer" Token (opção de baixo). Copie esse número.
Por fim, retornar ao "Method POST" [Post_Language], procurar a opção "Bearer Token" em "Authorization e o Token será automaticamente preenchido no lado direito. Caso isto não ocorra, cole o número salvo no campo "Token". 
Agora é possível incluir um novo item, como feito antes, e apertar "Send". Seus itens estarão na sua tabela [Languages] dentro da DynamoDB.

