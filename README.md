# capacitor-plugin-buildinfo

Capacitor plugin to get build information

## Install

To use npm

```bash
npm install capacitor-plugin-buildinfo
````

To use yarn

```bash
yarn add capacitor-plugin-buildinfo
```

Sync native files

```bash
npx cap sync
```

## API

<docgen-index>

* [`getBuildInfo()`](#getbuildinfo)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### getBuildInfo()

```typescript
getBuildInfo() => Promise<BuildInfoResponse>
```

**Returns:** <code>Promise&lt;<a href="#buildinforesponse">BuildInfoResponse</a>&gt;</code>

--------------------


### Interfaces


#### BuildInfoResponse

| Prop                  | Type                          | Description                 |
| --------------------- | ----------------------------- | --------------------------- |
| **`baseUrl`**         | <code>string \| null</code>   | Base URL of the app         |
| **`packageName`**     | <code>string</code>           | Package Name (Bundle ID)    |
| **`basePackageName`** | <code>string</code>           | Base Package Name           |
| **`displayName`**     | <code>string</code>           | Display Name                |
| **`name`**            | <code>string</code>           | App Name                    |
| **`version`**         | <code>string</code>           | Version String              |
| **`versionCode`**     | <code>string \| number</code> | Version Code (Build Number) |
| **`debug`**           | <code>boolean</code>          | Debug flag                  |
| **`buildDate`**       | <code>string</code>           | Build Date                  |
| **`installDate`**     | <code>string</code>           | Install Date                |
| **`buildType`**       | <code>string</code>           | Build Type                  |
| **`flavor`**          | <code>string</code>           | Flavor                      |

</docgen-api>
