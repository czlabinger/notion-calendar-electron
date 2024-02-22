#!/usr/bin/env node

const { app, BrowserWindow } = require('electron');

app.on('ready', () => {

  // Create a new window
  let win = new BrowserWindow({ width: 800, height: 600 });

  // Load the external website
  win.loadURL('https://calendar.notion.so/');

});
