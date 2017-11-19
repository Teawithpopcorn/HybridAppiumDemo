const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('recipesDB.json');
const middlewares = jsonServer.defaults();
const port = process.env.PORT || 3030;

server.use(middlewares);
server.use(router);

console.log("-----start server at port:", port)

server.listen(port);
