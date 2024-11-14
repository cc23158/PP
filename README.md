# Shape Factory

## Descrição
**Shape Factory** é o aplicativo definitivo para quem busca atingir o auge corporal, oferecendo uma experiência personalizada que combina **treino**, **nutrição** e **motivação**. Seja para alcançar novos patamares de performance ou transformar completamente seu corpo, o Shape Factory é o parceiro que você precisa para fazer isso de forma inteligente e eficaz.

## Funcionalidades
* Cadastro de usuários
* Planos de treinos personalizados
* Gestão de exercícios
* Armazenamento dos vídeos de treinos
* Armazenamento de guias detalhados de cada exercício
* Rastreamento de desempenho
* Gráfico de progresso
* Armazenamento de receitas
* Insights personalizados

___________________________________________________________________________________________________________

### Banco de Dados (Disponível em: https://github.com/VictorYJM/Shape_Factory)
* Implementado em um FireBase (SupaBase) na linguagem PostgreSQL

|**Tabelas**|**Responsabilidade**|
|--------------|-------------------------------------------------------------------------------------------------------------|
| **Client**   | Armazena os dados relacionados ao usuário do aplicativo                                                     |
| **Adm**      | Armazena os dados relacionados aos administradores do aplicativo                                            |
| **Muscle**   | Armazena os dados relacionados aos músculos a serem estimulados                                             |
| **Training** | Relaciona os dados do treino (nome e categoria) a um cliente                                                |
| **Recipe**   | Relaciona os exercícios aos seus respectivos treinos, levando em consideração os pesos, repetições e séries |
| **History**  | Armazena os dados necessários para o rastreamento de progresso do cliente                                   |

<br>

|**Procedimentos Armazenados**|**Responsabilidade**|
|----------------------------|---------------------------------------------------------------------------|
| **GET_ClientByName**       | Retorna os dados de clientes baseado nos nomes                            |
| **GET_ClientByEmail**      | Retorna os dados de um cliente baseado no seu email                       |
| **GET_Adm**                | Retorna se as credenciais do administrador (email e senha) estão corretas |
| **GET_Exercise**           | Retorna os dados dos exercícios de acordo com o músculo estimulado        |
| **GET_TrainingByClient**   | Retorna os dados dos treinos de acordo com o usuário                      |
| **GET_TrainingByCategory** | Retorna os dados dos treinos de acordo com a categoria                    |
| **GET_Recipe**             | Retorna os exercícios de um treino                                        |
| **GET_HistoryByClient**    | Retorna os dados do histórico de cada cliente                             |

<br>

|**Visões**|**Responsabilidades**|
|---------------------|------------------------------------------------------------------------------|
| **V_ActiveClients** | Retorna os dados dos clientes que estão ativos no sistema                    |
| **V_ActiveAdm**     | Retorna os dados dos administradores que estão ativos no sistema             |
| **V_ClientOrder**   | Retorna os dados dos clientes ordenados pelo identificador do sistema        |
| **V_AdmOrder**      | Retorna os dados dos administradores ordenados pelo identificador do sistema |
| **V_MuscleOrder**   | Retorna os dados dos músculos ordenados alfabeticamente                      |
| **V_ExerciseOrder** | Retorna os dados dos exercícios ordenados alfabeticamente                    |
| **V_TrainingOrder** | Retorna os exercícios de um treino ordenados pelo identificador do sistema   |

<br>

|**Gatilhos**|**Responsabilidades**|
|--------------------|------------------------------------------------------------------------------------------------|
| **T_ClientInsert** | Verifica se os dados do cliente estão de acordo com os limites previstos para inseri-los       |
| **T_ClientUpdate** | Verifica se os dados do cliente estão de acordo com os limites previstos para mudá-los         |
| **T_AdmInsert**    | Verifica se os dados do administrador estão de acordo com os limites previstos para inseri-los |
| **T_AdmUpdate**    | Verifica se os dados do administrador estão de acordo com os limites previstos para mudá-los   |

___________________________________________________________________________________________________________

### Back-End (Disponível em: https://github.com/VictorYJM/Shape_Factory)
* Implementado em Spring Boot (Maven) na linguagem JAVA

|**Classes**|**Responsabilidades**|
|--------------|--------------------------------------------------|
| **Client**   | Representa a entidade Client do banco de dados   |
| **Adm**      | Representa a entidade Adm do banco de dados      |
| **Muscle**   | Representa a entidade Muscle do banco de dados   |
| **Training** | Representa a entidade Training do banco de dados |
| **Recipe**   | Representa a entidade Recipe do banco de dados   |
| **History**  | Representa a entidade History do banco de dados  |

<br>

|**Repositórios**|**Responsabilidades**|
|---------------|------------------------------------------------------|
| **IClient**   | Conexão entre a entidade Client e o banco de dados   |
| **IAdm**      | Conexão entre a entidade Adm e o banco de dados      |
| **IMuscle**   | Conexão entre a entidade Muscle e o banco de dados   |
| **ITraining** | Conexão entre a entidade Training e o banco de dados |
| **IRecipe**   | Conexão entre a entidade Recipe e o banco de dados   |
| **IHistory**  | Conexão entre a entidade History e o banco de dados  |

<br>

|**Serviços**|**Responsabilidades**|
|---------------------|-------------------------------------------------------------------------------------------------------------------|
| **ClientService**   | Trata da lógica relacionada aos dados de clientes e as operações do banco de dados                                |
| **AdmService**      | Trata da lógica relacionada aos dados de administradores e as operações do banco de dados                         |
| **MuscleService**   | Trata da lógica relacionada aos dados de músculos e as operações do banco de dados                                |
| **TrainingService** | Trata da lógica relacionada aos dados de treinos e as operações do banco de dados                                 |
| **RecipeService**   | Trata da lógica relacionada aos dados de exercícios e treinos e suas operações do banco de dados                  |
| **HistoryService**  | Trata da lógica relacionada aos dados dos relatórios de desempenho o cliente e suas operações do banco de dados   |
| **ImageService**    | Trata da lógica relacionada à manipulação de imagens do SupaBase e suas operações no banco de dados               |

<br>

|**Controles**|**Responsabilidades**|
|------------------------|------------------------------------------------------------------------------------------|
| **ClientController**   | Conexão entre o Front-End e a lógica do Back-End dos clientes                            |
| **AdmController**      | Conexão entre o Front-End e a lógica do Back-End dos administradores                     |
| **MuscleController**   | Conexão entre o Front-End e a lógica do Back-End dos músculos                            |
| **TrainingController** | Conexão entre o Front-End e a lógica do Back-End dos treinos                             |
| **RecipeController**   | Conexão entre o Front-End e a lógica do Back-End dos exercícios e treinos                |
| **HistoryController**  | Conexão entre o Front-End e a lógica do Back-End dos relatórios de desempenho do cliente |

___________________________________________________________________________________________________________

### Front-End (Disponível em: https://github.com/VictorYJM/Shape_Factory)
* Implementado em Flutter na linguagem Dart

|**Tela de Clientes**|**Funcionalidades**|
|----------------|-----------------|
| **Login** | Apresenta campos para o usuário inserir suas credenciais de acesso (email e senha) para entrar no aplicativo caso a verificação seja bem sucedida, caso contrário, retorna uma mensagem de credenciais incorretas |
| **Cadastro** | Apresenta campos para o usuário inserir seus dados pessoais (nome, email, data de nascimento, peso, gênero e senha) tentando assim, criar um login de acesso para o usuário baseado nos dados apresentados |
| **CentralPage** | Cria uma barra de navegação que oferece acesso à três diferentes telas, tela principal, tela de relatórios e tela da conta do usuário |
| **Home** | Apresenta os treinos padrões e personalizados do usuário |
| **Relatório** | Apresenta um gráfico de desempenho sobre quais músculos foram mais trabalhados, quantos dias treinados e um calendário com cada dia treinado pelo usuário abre uma página de histórico com os exercícios daquele dia |
| **Conta** | Apresenta os dados do cliente (nome, email, senha e peso), permitindo a atualização do peso e da senha, além de proporcionar o recurso de "deslogar" |
| **ActiveTrainingBar** | Apresenta uma barra de relatório do tempo gasto pelo usuário para executar todos os exercícios de um treino, o usuário não poderá iniciar outro treino antes de finalizar o que já está ativo |
| **EditTraining** | Apresenta todos os exercícios de um treino selecionado e permite a alteração de dados (peso, repetições e séries), adição e remoção de exercícios do treino |
| **Objetivo** | Apresenta objetivos para o usuário selecionar após o cadastro, perder peso, ganhar massa, ganhar flexibilidade ou força |
| **SelectExercises** | Tela de navegação dos exercícios, apresentando opções de filtragem por nome do exercício e músculo alvo, retornando a página de EditTraining os exercícios selecionados na ordem de seleção |
| **StartTraining** | Apresenta os dados de cada exercício presente no treino ativo e permite a atualização dos dados de cada um (peso, repetições e séries) |
| **ViewHistory** | Apresenta todos os exercícios treinados num determinado dia, tal dia é determinado pela seleção no calendário da tela de Relatório |

<br>

|**Tela de Administradores**|**Funcionalidades**|
|--------------|----------|
| **Login** | Apresenta campos para o usuário inserir suas credenciais de acesso (email e senha) para entrar no aplicativo caso a verificação seja bem sucedida, caso contrário, retorna uma mensagem de credenciais incorretas |
| **CentralPage** | Cria uma barra de navegação que oferece acesso à duas páginas, adicionar exercício e editar treino |
| **AddExercise** | Apresenta todos os exercícios do projeto e permite a adição de novos exercícios |
| **EditTraining** | Apresenta uma tela com o nome do treino (alterável) e permite adicionar e excluir exercícios, os dados de peso, repetições e séries estão incluídos como alteráveis |
| **SelectExercises** | Tela de navegação dos exercícios, apresentando opções de filtragem por nome do exercício e músculo alvo, retornando a página de EditTraining os exercícios selecionados na ordem de seleção |
| **SelectTraining** | Apresenta os treinos separados pela sua categoria (superior, inferior ou full-body) e permite adicionar, editar e excluir treinos existentes |

___________________________________________________________________________________________________________

# Tecnologias Utilizadas
* Banco de Dados (PostgreSQL)
* Firebase (SupaBase)
* Back-End (Java Spring Boot)
* Front-end (Flutter)
