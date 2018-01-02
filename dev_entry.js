/// IMPORTANT: This is not the entry point of the production app.
const electron = require('electron');
const express = require('express');
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;

const path = require('path');
const url = require('url');

const expressApp = express();
expressApp.use(express.static(path.join(__dirname, '.dart_tool', 'build', 'generated', 'app', 'web')));
expressApp.use(express.static(path.join(__dirname, 'web')));
expressApp.use('/node_modules', express.static(path.join(__dirname, 'node_modules')));
const rgx = /packages\/([^\/]+)\/([^$]+)/;

// IMPORTANT: Forward packages/ to packages/x/lib
expressApp.get(rgx, (req, res, next) => {
    const match = rgx.exec(req.path);
    const name = match[1], tail = match[2];
    if (name !== '$sdk' && tail.indexOf('lib') !== 0)
        res.redirect(`/packages/${name}/lib/${tail}`);
    else next();
});
expressApp.use('/packages', express.static(path.join(__dirname, '.dart_tool', 'build', 'generated')));
expressApp.use('/packages', express.static(path.join(__dirname, 'packages')));

const server = expressApp.listen(0);
server.on('listening', () => {
    let mainWindow;

    function createWindow() {
        mainWindow = new BrowserWindow({width: 800, height: 600});

        mainWindow.loadURL(`http://localhost:${server.address().port}`);

        mainWindow.on('closed', function () {
            mainWindow = null;
        })
    }

    app.on('ready', createWindow);

    app.on('window-all-closed', function () {
        if (process.platform !== 'darwin') {
            app.quit()
        }
    });

    app.on('activate', function () {
        if (mainWindow === null) {
            createWindow()
        }
    });
});