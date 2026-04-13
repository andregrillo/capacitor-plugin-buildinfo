import { WebPlugin } from '@capacitor/core';
export class BuildInfoWeb extends WebPlugin {
    async getBuildInfo() {
        return {
            baseUrl: window.location.href,
            packageName: 'web',
            basePackageName: 'web',
            displayName: 'Web',
            name: 'Web',
            version: '1.0.0',
            versionCode: 1,
            debug: true,
            buildDate: new Date().toISOString(),
            installDate: new Date().toISOString(),
            buildType: 'web',
            flavor: 'web'
        };
    }
}
//# sourceMappingURL=web.js.map