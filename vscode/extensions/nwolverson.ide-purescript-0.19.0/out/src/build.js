"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var vscode = require("vscode");
function pscPositionToRange(p) {
    return new vscode.Range(p.startLine - 1, p.startColumn - 1, p.endLine - 1, p.endColumn - 1);
}
exports.pscPositionToRange = pscPositionToRange;
//# sourceMappingURL=build.js.map