import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";
import { extractDesignTokens, FIGMA_FILE_KEY, figmaGet, findDartFiles, LIB_DIR, readFileContent, summariseNode, } from "./utils.js";
const server = new McpServer({
    name: "navega-mcp-server",
    version: "1.0.0",
});
server.tool("figma_node", "Fetch and summarize a Figma node from the Navega design file.", { nodeId: z.string().describe("Figma node ID, for example 23:1712") }, async ({ nodeId }) => {
    const response = (await figmaGet(`/v1/files/${FIGMA_FILE_KEY}/nodes?ids=${encodeURIComponent(nodeId)}`));
    const node = response.nodes?.[nodeId]?.document;
    if (!node) {
        throw new Error(`Figma node not found: ${nodeId}`);
    }
    return { content: [{ type: "text", text: summariseNode(node) }] };
});
server.tool("figma_tokens", "Extract colors, typography, spacing, and radii from a Figma node.", { nodeId: z.string().describe("Figma node ID") }, async ({ nodeId }) => {
    const response = (await figmaGet(`/v1/files/${FIGMA_FILE_KEY}/nodes?ids=${encodeURIComponent(nodeId)}`));
    const node = response.nodes?.[nodeId]?.document;
    if (!node) {
        throw new Error(`Figma node not found: ${nodeId}`);
    }
    return { content: [{ type: "text", text: JSON.stringify(extractDesignTokens(node), null, 2) }] };
});
server.tool("flutter_files", "List Dart files in the Navega Flutter lib directory.", {}, async () => ({ content: [{ type: "text", text: findDartFiles(LIB_DIR).join("\n") }] }));
server.tool("read_flutter_file", "Read a Dart file relative to the Navega Flutter project root.", { filePath: z.string().describe("Relative Dart file path") }, async ({ filePath }) => ({ content: [{ type: "text", text: readFileContent(filePath) }] }));
await server.connect(new StdioServerTransport());
//# sourceMappingURL=index.js.map