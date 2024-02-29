#!/usr/bin/env node

const { app, BrowserWindow,ipcMain} = require('electron');
const { Notification } = require('electron')

app.on('ready', () => {

    // Create a new window
    let win = new BrowserWindow({
        width: 800,
        height: 600
    });

    // Load the external website
    win.loadURL('https://calendar.notion.so/');

    win.webContents.openDevTools();

    Notification.requestPermission = () => {};
    Notification.permission = "granted";
    win.Notification = function(title, options) {
        console.log('Notification:', title, options);
        // Send the notification data to the main process
        require('electron').ipcRenderer.send('notification', {
            title,
            options
        });
    };

    win.webContents.setWindowOpenHandler((details) => {
        require('electron').shell.openExternal(details.url);
        return {
            action: 'deny'
        };
    });

});