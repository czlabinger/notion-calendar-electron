#!/usr/bin/env node

const { app, BrowserWindow, ipcMain } = require('electron');

app.on('ready', () => {
    // Create a new window
    let win = new BrowserWindow({
        width: 800,
        height: 600
    });

    // Load the external website
    win.loadURL('https://calendar.notion.so/');

    // Exclude specific links from being opened in the default browser
    const excludedLinks = ['https://calendar-api.notion.so/v1/auth'];

    win.webContents.setWindowOpenHandler((details) => {
        // Check if the link is in the excluded list
        if (excludedLinks.includes(details.url)) {
            // Handle the link as needed, e.g., open it in the Electron app or ignore it
            console.log('Excluded link:', details.url);
            return {
                action: 'deny'
            };
        } else {
            // Open other links in the default browser
            require('electron').shell.openExternal(details.url);
            return {
                action: 'deny'
            };
        }
    });
});
