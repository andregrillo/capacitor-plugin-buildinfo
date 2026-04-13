import { registerPlugin } from '@capacitor/core';

import type { BuildInfoPlugin } from './definitions';

const BuildInfo = registerPlugin<BuildInfoPlugin>('BuildInfo', {
  web: () => import('./web').then((m) => new m.BuildInfoWeb()),
});

export * from './definitions';
export { BuildInfo };
