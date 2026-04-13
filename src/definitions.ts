export interface BuildInfoPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
