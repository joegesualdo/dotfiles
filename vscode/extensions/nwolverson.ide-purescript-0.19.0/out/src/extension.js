"use strict";
var __assign = (this && this.__assign) || Object.assign || function(t) {
    for (var s, i = 1, n = arguments.length; i < n; i++) {
        s = arguments[i];
        for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
            t[p] = s[p];
    }
    return t;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = y[op[0] & 2 ? "return" : op[0] ? "throw" : "next"]) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [0, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
var vscode_1 = require("vscode");
var vscode_languageclient_1 = require("vscode-languageclient");
var clients = new Map();
var commandCode = new Map();
function activate(context) {
    var activatePS = require('./bundle');
    var opts = { module: 'purescript-language-server', transport: vscode_languageclient_1.TransportKind.ipc };
    var serverOptions = {
        run: opts,
        debug: __assign({}, opts, { options: {
                execArgv: [
                    "--nolazy",
                    "--inspect=6009"
                ]
            } })
    };
    var output = vscode_1.window.createOutputChannel("IDE PureScript");
    // Options to control the language client
    var clientOptions = function (folder) { return ({
        // Register only for PureScript documents in the given root folder
        documentSelector: [
            { scheme: 'file', language: 'purescript', pattern: folder.uri.fsPath + "/**/*" }
        ].concat(folder.index === 0 ? [{ scheme: 'untitled', language: 'purescript' }] : []),
        workspaceFolder: folder,
        synchronize: {
            configurationSection: 'purescript',
            fileEvents: vscode_1.workspace.createFileSystemWatcher('**/*.purs')
        },
        outputChannel: output,
        revealOutputChannelOn: vscode_languageclient_1.RevealOutputChannelOn.Never,
        errorHandler: {
            error: function (e, m, c) { console.error(e, m, c); return vscode_languageclient_1.ErrorAction.Continue; },
            closed: function () { return vscode_languageclient_1.CloseAction.DoNotRestart; }
        },
        initializationOptions: {
            executeCommandProvider: false
        }
    }); };
    var commandNames = [
        "caseSplit-explicit",
        "addClause-explicit",
        "addCompletionImport",
        "addModuleImport",
        "replaceSuggestion",
        "replaceAllSuggestions",
        "build",
        "typedHole-explicit",
        "startPscIde",
        "stopPscIde",
        "restartPscIde",
        "getAvailableModules",
        "search"
    ].map(function (x) { return "purescript." + x; });
    var getWorkspaceFolder = function (doc) {
        if (doc.uri.scheme === 'file') {
            var wf = vscode_1.workspace.getWorkspaceFolder(doc.uri);
            if (wf) {
                return wf;
            }
        }
        if (vscode_1.workspace.workspaceFolders.length > 0) {
            return vscode_1.workspace.workspaceFolders[0];
        }
        return null;
    };
    commandNames.forEach(function (command) {
        vscode_1.commands.registerTextEditorCommand(command, function (ed, edit) {
            var args = [];
            for (var _i = 2; _i < arguments.length; _i++) {
                args[_i - 2] = arguments[_i];
            }
            var wf = getWorkspaceFolder(ed.document);
            if (!wf) {
                return;
            }
            var lc = clients.get(wf.uri.toString());
            if (!lc) {
                output.appendLine("Didn't find language client for " + ed.document.uri);
                return;
            }
            lc.sendRequest(vscode_languageclient_1.ExecuteCommandRequest.type, { command: command, arguments: args });
        });
    });
    var extensionCmd = function (cmdName) { return function (ed, edit) {
        var args = [];
        for (var _i = 2; _i < arguments.length; _i++) {
            args[_i - 2] = arguments[_i];
        }
        var wf = getWorkspaceFolder(ed.document);
        if (!wf) {
            return;
        }
        var cmds = commandCode.get(wf.uri.toString());
        if (!cmds) {
            output.appendLine("Didn't find language client for " + ed.document.uri);
            return;
        }
        cmds[cmdName](args);
    }; };
    function didOpenTextDocument(document) {
        var _this = this;
        if (document.languageId !== 'purescript' || document.uri.scheme !== 'file') {
            return;
        }
        var folder = vscode_1.workspace.getWorkspaceFolder(document.uri);
        if (!folder) {
            console.log("Didn't find workspace folder for " + document.uri);
            return;
        }
        if (!clients.has(folder.uri.toString())) {
            try {
                output.appendLine("Launching new language client for " + folder.uri.toString());
                var client_1 = new vscode_languageclient_1.LanguageClient('PureScript', 'IDE PureScript', serverOptions, clientOptions(folder));
                client_1.registerProposedFeatures();
                client_1.onReady().then(function () { return __awaiter(_this, void 0, void 0, function () {
                    var _this = this;
                    var cmds, cmdNames;
                    return __generator(this, function (_a) {
                        switch (_a.label) {
                            case 0:
                                output.appendLine("Activated lc for " + folder.uri.toString());
                                cmds = activatePS(client_1);
                                return [4 /*yield*/, vscode_1.commands.getCommands()];
                            case 1:
                                cmdNames = _a.sent();
                                commandCode.set(folder.uri.toString(), cmds);
                                Promise.all(Object.keys(cmds).map(function (cmd) { return __awaiter(_this, void 0, void 0, function () {
                                    return __generator(this, function (_a) {
                                        if (cmdNames.indexOf(cmd) === -1) {
                                            vscode_1.commands.registerTextEditorCommand(cmd, extensionCmd(cmd));
                                        }
                                        return [2 /*return*/];
                                    });
                                }); }));
                                return [2 /*return*/];
                        }
                    });
                }); }).catch(function (err) { return output.appendLine(err); });
                client_1.start();
                clients.set(folder.uri.toString(), client_1);
            }
            catch (e) {
                output.appendLine(e);
            }
        }
    }
    vscode_1.workspace.onDidOpenTextDocument(didOpenTextDocument);
    vscode_1.workspace.textDocuments.forEach(didOpenTextDocument);
    vscode_1.workspace.onDidChangeWorkspaceFolders(function (event) {
        for (var _i = 0, _a = event.removed; _i < _a.length; _i++) {
            var folder = _a[_i];
            var client = clients.get(folder.uri.toString());
            if (client) {
                clients.delete(folder.uri.toString());
                client.stop();
            }
        }
    });
}
exports.activate = activate;
function deactivate() {
    var promises = [];
    for (var _i = 0, _a = Array.from(clients.values()); _i < _a.length; _i++) {
        var client = _a[_i];
        promises.push(client.stop());
    }
    return Promise.all(promises).then(function () { return undefined; });
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map