import type { BuildInfoResponse } from './definitions';
export declare class BuildInfo {
    static baseUrl: string | null;
    static packageName: string;
    static basePackageName: string;
    static displayName: string;
    static appName: string;
    static version: string;
    static versionCode: string | number;
    static debug: boolean;
    static buildDate: string;
    static installDate: string;
    static buildType: string;
    static flavor: string;
    static init(): Promise<BuildInfoResponse>;
    /**
     * Directly call the native getBuildInfo method
     */
    static getBuildInfo(): Promise<BuildInfoResponse>;
}
export * from './definitions';
