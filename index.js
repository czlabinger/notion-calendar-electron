#!/usr/bin/env node

const { app, BrowserWindow } = require('electron');

app.whenReady().then(() => {
  
console.log('App is ready');
  
  app.on('ready', () => {
    console.log('App on ready event');

    let win = new BrowserWindow({
        width: 800,
        height: 600,
        autoHideMenuBar: true,
    });

    // Load the external website
    win.loadURL('https://calendar.notion.so/');

    //win.webContents.openDevTools();

    win.webContents.setWindowOpenHandler((details) => {

		console.log(typeof details.url);

		if(details.url.includes("https://calendar.notion.so/google-permissions")) {
        		return {
            			action: 'allow'
        		};
		}

        require('electron').shell.openExternal(details.url);
        return {
            action: 'deny'
        };
    });

  });
});
