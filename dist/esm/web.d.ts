import { WebPlugin } from '@capacitor/core';
import type { BuildInfoPlugin, BuildInfoResponse } from './definitions';
export declare class BuildInfoWeb extends WebPlugin implements BuildInfoPlugin {
    getBuildInfo(): Promise<BuildInfoResponse>;
}
