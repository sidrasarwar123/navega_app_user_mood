export declare const FIGMA_TOKEN: string;
export declare const FIGMA_FILE_KEY = "jQUoYf8cF2rGV8Yas5cbDy";
export declare const PROJECT_ROOT: string;
export declare const LIB_DIR: string;
export declare function figmaGet(apiPath: string): Promise<unknown>;
export declare function findDartFiles(dir: string): string[];
export declare function readFileContent(filePath: string): string;
interface FigmaNode {
    id: string;
    name: string;
    type: string;
    children?: FigmaNode[];
    absoluteBoundingBox?: {
        x: number;
        y: number;
        width: number;
        height: number;
    };
    fills?: Array<{
        type: string;
        color?: {
            r: number;
            g: number;
            b: number;
            a: number;
        };
        blendMode?: string;
    }>;
    characters?: string;
    style?: {
        fontFamily?: string;
        fontSize?: number;
        fontWeight?: number;
    };
    cornerRadius?: number;
    strokeWeight?: number;
    strokes?: Array<{
        type: string;
        color?: {
            r: number;
            g: number;
            b: number;
            a: number;
        };
    }>;
    effects?: Array<{
        type: string;
        radius?: number;
        color?: {
            r: number;
            g: number;
            b: number;
            a: number;
        };
    }>;
    constraints?: {
        vertical: string;
        horizontal: string;
    };
    layoutMode?: string;
    primaryAxisSizingMode?: string;
    counterAxisSizingMode?: string;
    paddingLeft?: number;
    paddingRight?: number;
    paddingTop?: number;
    paddingBottom?: number;
    itemSpacing?: number;
}
export declare function summariseNode(node: FigmaNode, depth?: number, maxDepth?: number): string;
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
export declare function extractDesignTokens(node: FigmaNode): DesignTokens;
export {};
//# sourceMappingURL=utils.d.ts.map