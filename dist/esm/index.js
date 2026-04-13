import { registerPlugin } from '@capacitor/core';
const BuildInfoNative = registerPlugin('BuildInfo', {
    web: () => import('./web').then((m) => new m.BuildInfoWeb()),
});
export class BuildInfo {
    static async init() {
        const res = await BuildInfoNative.getBuildInfo();
        this.baseUrl = window.location.href; // Default to current URL if not provided by native
        if (res.baseUrl) {
            this.baseUrl = res.baseUrl;
        }
        this.packageName = res.packageName;
        this.basePackageName = res.basePackageName;
        this.displayName = res.displayName;
        this.appName = res.name;
        this.version = res.version;
        this.versionCode = res.versionCode;
        this.debug = res.debug;
        this.buildDate = res.buildDate;
        this.installDate = res.installDate;
        this.buildType = res.buildType;
        this.flavor = res.flavor;
        return Object.assign(Object.assign({}, res), { baseUrl: this.baseUrl });
    }
    /**
     * Directly call the native getBuildInfo method
     */
    static async getBuildInfo() {
        return BuildInfoNative.getBuildInfo();
    }
}
BuildInfo.baseUrl = null;
BuildInfo.packageName = '';
BuildInfo.basePackageName = '';
BuildInfo.displayName = '';
BuildInfo.appName = '';
BuildInfo.version = '';
BuildInfo.versionCode = '';
BuildInfo.debug = false;
BuildInfo.buildDate = '';
BuildInfo.installDate = '';
BuildInfo.buildType = '';
BuildInfo.flavor = '';
export * from './definitions';
//# sourceMappingURL=index.js.map