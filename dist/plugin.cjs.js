'use strict';

var core = require('@capacitor/core');

const BuildInfoNative = core.registerPlugin('BuildInfo', {
    web: () => Promise.resolve().then(function () { return web; }).then((m) => new m.BuildInfoWeb()),
});
class BuildInfo {
    static async init() {
        const res = await BuildInfoNative.getBuildInfo();
        this.baseUrl = (res.baseUrl && res.baseUrl !== "") ? res.baseUrl : window.location.href;
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
        // Return the response with name field for backward compatibility
        return Object.assign(Object.assign({}, res), { baseUrl: this.baseUrl, name: res.name });
    }
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

class BuildInfoWeb extends core.WebPlugin {
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

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    BuildInfoWeb: BuildInfoWeb
});

exports.BuildInfo = BuildInfo;
//# sourceMappingURL=plugin.cjs.js.map
