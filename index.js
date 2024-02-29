#!/usr/bin/env node

const { app, BrowserWindow,ipcMain} = require('electron');

app.on('ready', () => {

    // Create a new window
    let win = new BrowserWindow({
        width: 800,
        height: 600
    });

    // Load the external website
    win.loadURL('https://calendar.notion.so/');

    //win.webContents.openDevTools();

    win.webContents.setWindowOpenHandler((details) => {
        require('electron').shell.openExternal(details.url);
        return {
            action: 'deny'
        };
    });

});