"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var vscode_1 = require("vscode");
function replaceSuggestion(fileName, range, replacement, suggestRange) {
    console.log("Replacing", range, suggestRange);
    var doc = vscode_1.workspace.openTextDocument(fileName).then(function (doc) {
        var trailingNewline = /\n\s+$/.test(replacement);
        var endText = doc.getText(new vscode_1.Range(suggestRange.end, suggestRange.end.translate(0, 10)));
        var addNewline = trailingNewline && !(endText.length == 0);
        var edit = new vscode_1.WorkspaceEdit();
        // TODO: This will break after edits have happened
        edit.replace(doc.uri, suggestRange, replacement.trim() + (addNewline ? "\n" : ""));
        vscode_1.workspace.applyEdit(edit);
    }).then(null, function (e) {
        console.error("Error in replaceSuggestion action: " + e);
    });
}
var BuildActionProvider = (function () {
    function BuildActionProvider() {
    }
    BuildActionProvider.prototype.setBuildResults = function (result) {
        this.buildResults = result;
    };
    BuildActionProvider.prototype.provideCodeActions = function (document, range, context, token) {
        var _this = this;
        return context.diagnostics
            .filter(function (d) { return d.range.contains(range); })
            .map(function (d) {
            var code = d.code;
            if (typeof code === "number") {
                return _this.buildResults.get(code);
            }
            else {
                return _this.buildResults.get(parseInt(code, 10));
            }
        })
            .filter(function (d) { return d !== undefined && d.quickfix.suggest; })
            .map(function (d) {
            return ({
                command: "purescript.replaceSuggestion",
                title: "Apply Suggestion",
                arguments: [document.fileName, d.diagnostic.range, d.quickfix.replacement, d.quickfix.range]
            });
        });
    };
    return BuildActionProvider;
}());
exports.BuildActionProvider = BuildActionProvider;
var CodeActionCommands = (function () {
    function CodeActionCommands() {
        this.registerCommands();
    }
    CodeActionCommands.prototype.registerCommands = function () {
        this.commands = [
            vscode_1.commands.registerCommand("purescript.replaceSuggestion", replaceSuggestion)
        ];
    };
    CodeActionCommands.prototype.dispose = function () {
        this.commands.forEach(function (d) { return d.dispose(); });
    };
    return CodeActionCommands;
}());
exports.CodeActionCommands = CodeActionCommands;
//# sourceMappingURL=codeActions.js.map