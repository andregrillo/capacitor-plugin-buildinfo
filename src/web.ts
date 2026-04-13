import { WebPlugin } from '@capacitor/core';

import type { BuildInfoPlugin } from './definitions';

export class BuildInfoWeb extends WebPlugin implements BuildInfoPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
