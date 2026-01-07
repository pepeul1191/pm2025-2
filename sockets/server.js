// server.js
const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const cors = require('cors');

const app = express();
const server = http.createServer(app);

// Configurar CORS para Flutter
app.use(cors({
  origin: "*", // En producción, especifica tu dominio
  methods: ["GET", "POST"]
}));

const wss = new WebSocket.Server({ 
  server,
  path: '/ws' // Ruta específica para WebSockets
});

// Almacén de clientes conectados
const clients = new Map();
let userCount = 0;

// Endpoint de salud para verificar que el servidor funciona
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'ok', 
    connectedClients: clients.size,
    timestamp: new Date().toISOString()
  });
});

// WebSocket connection
wss.on('connection', (ws, req) => {
  const userId = ++userCount;
  const clientInfo = { 
    id: userId, 
    name: `Usuario${userId}`,
    platform: req.headers['user-agent'] || 'unknown'
  };
  
  clients.set(ws, clientInfo);
  
  console.log(`Cliente ${userId} conectado desde: ${clientInfo.platform}`);

  // Enviar mensaje de bienvenida
  ws.send(JSON.stringify({
    type: 'connection_established',
    message: 'Conexión WebSocket establecida',
    userId: userId,
    userCount: clients.size
  }));

  // Notificar a todos sobre nuevo usuario
  broadcastToAll({
    type: 'user_joined',
    userId: userId,
    userName: clientInfo.name,
    userCount: clients.size,
    timestamp: new Date().toISOString()
  });

  // Manejar mensajes del cliente
  ws.on('message', (data) => {
    try {
      const message = JSON.parse(data);
      console.log(message);
      const user = clients.get(ws);
      
      console.log(`Mensaje de ${user.name}:`, message);
      
      // Validar estructura del mensaje
      if (!message.type || !message.content) {
        ws.send(JSON.stringify({
          type: 'error',
          message: 'Formato de mensaje inválido'
        }));
        return;
      }
      
      // Procesar diferentes tipos de mensajes
      switch (message.type) {
        case 'chat_message':
          broadcastToAll({
            type: 'chat_message',
            userId: user.id,
            userName: user.name,
            content: message.content,
            timestamp: new Date().toISOString()
          });
          break;
          
        case 'typing_start':
          broadcastToOthers(ws, {
            type: 'user_typing',
            userId: user.id,
            userName: user.name,
            isTyping: true
          });
          break;
          
        case 'typing_stop':
          broadcastToOthers(ws, {
            type: 'user_typing',
            userId: user.id,
            userName: user.name,
            isTyping: false
          });
          break;
          
        default:
          ws.send(JSON.stringify({
            type: 'error',
            message: 'Tipo de mensaje no soportado'
          }));
      }
      
    } catch (error) {
      console.error('Error procesando mensaje:', error);
      ws.send(JSON.stringify({
        type: 'error',
        message: 'Error procesando mensaje'
      }));
    }
  });

  // Manejar ping/pong para mantener conexión
  ws.isAlive = true;
  ws.on('pong', () => {
    ws.isAlive = true;
  });

  // Manejar desconexión
  ws.on('close', () => {
    const user = clients.get(ws);
    console.log(`Cliente ${user.id} desconectado`);
    
    clients.delete(ws);
    
    // Notificar a todos sobre la desconexión
    broadcastToAll({
      type: 'user_left',
      userId: user.id,
      userName: user.name,
      userCount: clients.size,
      timestamp: new Date().toISOString()
    });
  });

  // Manejar errores
  ws.on('error', (error) => {
    console.error('Error de WebSocket:', error);
  });
});

// Función para broadcast a todos los clientes
function broadcastToAll(message) {
  const messageStr = JSON.stringify(message);
  clients.forEach((user, ws) => {
    if (ws.readyState === WebSocket.OPEN) {
      ws.send(messageStr);
    }
  });
}

// Función para broadcast a todos excepto al remitente
function broadcastToOthers(senderWs, message) {
  const messageStr = JSON.stringify(message);
  clients.forEach((user, ws) => {
    if (ws !== senderWs && ws.readyState === WebSocket.OPEN) {
      ws.send(messageStr);
    }
  });
}

// Heartbeat para detectar conexiones muertas
setInterval(() => {
  wss.clients.forEach((ws) => {
    if (ws.isAlive === false) {
      console.log('Terminando conexión muerta');
      return ws.terminate();
    }
    
    ws.isAlive = false;
    ws.ping();
  });
}, 30000);

// Iniciar servidor
const PORT = process.env.PORT || 3000;
server.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Servidor corriendo en puerto ${PORT}`);
  console.log(`📡 WebSocket disponible en: ws://localhost:${PORT}/ws`);
  console.log(`🌐 Health check en: http://localhost:${PORT}/api/health`);
});