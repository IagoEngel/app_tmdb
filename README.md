# App TMDB
Um projeto Flutter utilizando a api TMDB para exibir e pesquisar filmes.

## Passo-a-passo
Esse projeto utilizou a versão 3.22.2 do Flutter. Para mudar a versão do flutter instalado na sua máquina, vá para a pasta onde o sdk está localizado "< local de instalacao >/flutter" e execute o seguinte comando no terminal: "git checkout 3.22.2".
No terminal apontado para o local deste projeto, execute os seguintes comandos: "flutter doctor", "flutter clean" e "flutter pub get".

Em seguida, crie o arquivo .env na raiz do projeto seguindo a estrutura do arquivo .env.template. No arquivo .env, utilize as chaves da sua conta TMDB localizadas no link https://www.themoviedb.org/settings/api. 

Enfim, você poderá executar o projeto com o comando "flutter run --profile";

## Arquitetura utilizada
A arquitetura utilzada como base foi a MVVM.

-> O arquivo que cria a base de conexão com a api pode ser encontrado na pasta "repository", sendo chamado de custom_dio_repository. Os arquivos que se comunicam com a api e têm rotas mais específicas também se encontram nesta pasta;
-> Obtendo as respostas da api, precisamos convertê-las em classes. E estas classes podem ser encontradas na pasta "domain/models". Elas utilizam o construtor .fromJson() para atribuir os valores recebidos.
-> O tema e os componentes personalizados pode ser encontrados na pasta "ui/core".
-> Na pasta "utils", está o arquivo(dimensoes_app) responsável por manter as dimensões do app responsivas.
-> E, na pasta "view model", encontrando os arquivos que fazem o gerenciamento de estado do app.
