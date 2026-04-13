export interface BuildInfoResponse {
    /**
     * Base URL of the app
     */
    baseUrl: string | null;
    /**
     * Package Name (Bundle ID)
     */
    packageName: string;
    /**
     * Base Package Name
     */
    basePackageName: string;
    /**
     * Display Name
     */
    displayName: string;
    /**
     * App Name
     */
    name: string;
    /**
     * Version String
     */
    version: string;
    /**
     * Version Code (Build Number)
     */
    versionCode: string | number;
    /**
     * Debug flag
     */
    debug: boolean;
    /**
     * Build Date
     */
    buildDate: string;
    /**
     * Install Date
     */
    installDate: string;
    /**
     * Build Type
     */
    buildType: string;
    /**
     * Flavor
     */
    flavor: string;
}
export interface BuildInfoPlugin {
    getBuildInfo(): Promise<BuildInfoResponse>;
}
