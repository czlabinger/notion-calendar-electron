const electron = require('electron')
const app = electron.app

app.on('ready', () => {
  const { BrowserWindow } = require('electron')

  // Create a new window
  let win = new BrowserWindow({ width: 800, height: 600 })

  // Load the external website
  win.loadURL('https://calendar.notion.so/')

})
