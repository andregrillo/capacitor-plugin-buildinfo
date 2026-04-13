import { WebPlugin } from '@capacitor/core';

import type { BuildInfoPlugin, BuildInfoResponse } from './definitions';

export class BuildInfoWeb extends WebPlugin implements BuildInfoPlugin {
  async getBuildInfo(): Promise<BuildInfoResponse> {
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
