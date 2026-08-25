import https from "node:https";
import path from "node:path";
import fs from "node:fs";

// ─── Figma Configuration ────────────────────────────────────────────
export const FIGMA_TOKEN = process.env.FIGMA_TOKEN ?? "";
export const FIGMA_FILE_KEY = "jQUoYf8cF2rGV8Yas5cbDy";

// ─── Project Paths ──────────────────────────────────────────────────
const SCRIPT_DIR = path.dirname(new URL(import.meta.url).pathname);
// Resolve the navega_app project root (two levels up from dist/)
// On Windows, remove leading '/' from '/D:/...'
function normalizePath(p: string): string {
  if (process.platform === "win32" && p.startsWith("/")) {
    return p.slice(1);
  }
  return p;
}
export const PROJECT_ROOT = normalizePath(
  path.resolve(SCRIPT_DIR, "..", "..")
);
export const LIB_DIR = path.join(PROJECT_ROOT, "lib");

// ─── Figma API Helper ───────────────────────────────────────────────
export function figmaGet(apiPath: string): Promise<unknown> {
  if (!FIGMA_TOKEN) {
    return Promise.reject(new Error("FIGMA_TOKEN is not configured"));
  }

  return new Promise((resolve, reject) => {
    const options: https.RequestOptions = {
      hostname: "api.figma.com",
      path: apiPath,
      method: "GET",
      headers: { "X-Figma-Token": FIGMA_TOKEN },
    };

    const req = https.request(options, (res) => {
      let body = "";
      res.on("data", (chunk: Buffer) => (body += chunk.toString()));
      res.on("end", () => {
        if (res.statusCode && res.statusCode >= 400) {
          reject(
            new Error(
              `Figma API ${res.statusCode}: ${body.substring(0, 300)}`
            )
          );
          return;
        }
        try {
          resolve(JSON.parse(body));
        } catch {
          reject(new Error(`Invalid JSON from Figma API: ${body.substring(0, 200)}`));
        }
      });
    });

    req.on("error", reject);
    req.end();
  });
}

// ─── File System Helpers ────────────────────────────────────────────
export function findDartFiles(dir: string): string[] {
  const results: string[] = [];
  if (!fs.existsSync(dir)) return results;

  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      // Skip build directories
      if (entry.name === "build" || entry.name === ".dart_tool") continue;
      results.push(...findDartFiles(fullPath));
    } else if (entry.name.endsWith(".dart")) {
      results.push(fullPath);
    }
  }
  return results;
}

export function readFileContent(filePath: string): string {
  const resolved = path.isAbsolute(filePath)
    ? filePath
    : path.join(PROJECT_ROOT, filePath);

  if (!fs.existsSync(resolved)) {
    throw new Error(`File not found: ${resolved}`);
  }
  return fs.readFileSync(resolved, "utf-8");
}

// ─── Figma Node Summariser ──────────────────────────────────────────
interface FigmaNode {
  id: string;
  name: string;
  type: string;
  children?: FigmaNode[];
  absoluteBoundingBox?: { x: number; y: number; width: number; height: number };
  fills?: Array<{ type: string; color?: { r: number; g: number; b: number; a: number }; blendMode?: string }>;
  characters?: string;
  style?: { fontFamily?: string; fontSize?: number; fontWeight?: number };
  cornerRadius?: number;
  strokeWeight?: number;
  strokes?: Array<{ type: string; color?: { r: number; g: number; b: number; a: number } }>;
  effects?: Array<{ type: string; radius?: number; color?: { r: number; g: number; b: number; a: number } }>;
  constraints?: { vertical: string; horizontal: string };
  layoutMode?: string;
  primaryAxisSizingMode?: string;
  counterAxisSizingMode?: string;
  paddingLeft?: number;
  paddingRight?: number;
  paddingTop?: number;
  paddingBottom?: number;
  itemSpacing?: number;
}

function rgbToHex(c: { r: number; g: number; b: number }): string {
  return (
    "#" +
    [c.r, c.g, c.b]
      .map((v) => Math.round(v * 255).toString(16).padStart(2, "0"))
      .join("")
  );
}

export function summariseNode(node: FigmaNode, depth = 0, maxDepth = 100): string {
  if (depth > maxDepth) return "";

  const indent = "  ".repeat(depth);
  let line = `${indent}[${node.type}] "${node.name}" (${node.id})`;

  if (node.absoluteBoundingBox) {
    const b = node.absoluteBoundingBox;
    line += ` ${Math.round(b.width)}×${Math.round(b.height)}`;
  }

  if (node.fills?.length) {
    const solid = node.fills.find((f) => f.type === "SOLID" && f.color);
    if (solid?.color) line += ` fill:${rgbToHex(solid.color)}`;
  }

  if (node.characters) {
    const text = node.characters.length > 40
      ? node.characters.substring(0, 40) + "…"
      : node.characters;
    line += ` text:"${text}"`;
  }

  if (node.style?.fontFamily) {
    line += ` font:${node.style.fontFamily}/${node.style.fontSize ?? "?"}`;
  }

  let result = line + "\n";

  if (node.children) {
    for (const child of node.children) {
      result += summariseNode(child, depth + 1, maxDepth);
    }
  }
  return result;
}

// ─── Design Token Extractor ─────────────────────────────────────────
interface DesignTokens {
  colors: Record<string, string>;
  typography: Array<{
    fontFamily: string;
    fontSize: number;
    fontWeight?: number;
    usage: string;
  }>;
  spacing: Array<{
    context: string;
    padding?: string;
    itemSpacing?: number;
  }>;
  cornerRadii: number[];
}

export function extractDesignTokens(node: FigmaNode): DesignTokens {
  const colors = new Map<string, string>();
  const typography: DesignTokens["typography"] = [];
  const spacing: DesignTokens["spacing"] = [];
  const cornerRadii = new Set<number>();

  function walk(n: FigmaNode): void {
    // Collect colours
    if (n.fills?.length) {
      for (const fill of n.fills) {
        if (fill.type === "SOLID" && fill.color) {
          const hex = rgbToHex(fill.color);
          const key = hex.toUpperCase();
          if (!colors.has(key)) {
            colors.set(key, n.name);
          }
        }
      }
    }

    // Collect typography
    if (n.type === "TEXT" && n.style?.fontFamily && n.style.fontSize) {
      const exists = typography.find(
        (t) =>
          t.fontFamily === n.style!.fontFamily &&
          t.fontSize === n.style!.fontSize &&
          t.fontWeight === n.style!.fontWeight
      );
      if (!exists) {
        typography.push({
          fontFamily: n.style.fontFamily,
          fontSize: n.style.fontSize,
          fontWeight: n.style.fontWeight,
          usage: n.characters?.substring(0, 30) ?? n.name,
        });
      }
    }

    // Collect corner radii
    if (n.cornerRadius && n.cornerRadius > 0) {
      cornerRadii.add(Math.round(n.cornerRadius));
    }

    // Collect spacing (auto-layout frames)
    if (n.layoutMode && (n.paddingLeft || n.itemSpacing)) {
      spacing.push({
        context: n.name,
        padding: `${n.paddingTop ?? 0} ${n.paddingRight ?? 0} ${n.paddingBottom ?? 0} ${n.paddingLeft ?? 0}`,
        itemSpacing: n.itemSpacing,
      });
    }

    if (n.children) {
      for (const child of n.children) walk(child);
    }
  }

  walk(node);

  const colorObj: Record<string, string> = {};
  for (const [hex, name] of colors) {
    colorObj[hex] = name;
  }

  return {
    colors: colorObj,
    typography: typography.sort((a, b) => b.fontSize - a.fontSize),
    spacing,
    cornerRadii: [...cornerRadii].sort((a, b) => a - b),
  };
}
