import { registerPlugin } from '@capacitor/core';
import type { BuildInfoPlugin, BuildInfoResponse } from './definitions';

const BuildInfoNative = registerPlugin<BuildInfoPlugin>('BuildInfo', {
  web: () => import('./web').then((m) => new m.BuildInfoWeb()),
});

export class BuildInfo {
  public static baseUrl: string | null = null;
  public static packageName: string = '';
  public static basePackageName: string = '';
  public static displayName: string = '';
  public static appName: string = '';
  public static version: string = '';
  public static versionCode: string | number = '';
  public static debug: boolean = false;
  public static buildDate: string = '';
  public static installDate: string = '';
  public static buildType: string = '';
  public static flavor: string = '';

  public static async init(): Promise<BuildInfoResponse> {
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
    return { 
        ...res, 
        baseUrl: this.baseUrl,
        name: res.name 
    };
  }

  public static async getBuildInfo(): Promise<BuildInfoResponse> {
    return BuildInfoNative.getBuildInfo();
  }
}

export * from './definitions';
