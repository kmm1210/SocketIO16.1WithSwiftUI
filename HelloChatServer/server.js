const express = require('express');
const http = require('http');
const socketIO = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIO(server);

// 포트 설정
const PORT = process.env.PORT || 3000;

// 클라이언트에서 오는 소켓 연결 처리
io.on('connection', (socket) => {
    console.log('New client connected');

    // 클라이언트가 메시지를 보냈을 때 처리
    socket.on('message', (data) => {
        console.log('Message received: ', data);

        // 모든 클라이언트에게 메시지 브로드캐스트
        // io.emit('message', data);

        // 메시지를 다른 클라이언트에게 브로드캐스트 (자신을 제외한 클라이언트에게만 전송)
        socket.broadcast.emit('message', data);
    });

    // 클라이언트가 연결을 끊었을 때 처리
    socket.on('disconnect', () => {
        console.log('Client disconnected');
    });
});

// 서버 실행
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
