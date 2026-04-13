package com.outsystems.experts.plugins.buildinfo;

import android.content.Context;
import android.content.pm.PackageInfo;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "BuildInfo")
public class BuildInfoPlugin extends Plugin {

    private BuildInfo implementation = new BuildInfo();

    @PluginMethod
    public void getBuildInfo(PluginCall call) {
        Context context = getContext();
        JSObject ret = new JSObject();

        String packageName = implementation.getPackageName(context);
        String displayName = implementation.getDisplayName(context);
        PackageInfo pi = implementation.getPackageInfo(context);

        ret.put("baseUrl", "");
        ret.put("packageName", packageName);
        ret.put("basePackageName", packageName);
        ret.put("displayName", displayName);
        ret.put("name", displayName);

        Object version = implementation.getBuildConfigValue(context, "VERSION_NAME");
        ret.put("version", version != null ? version.toString() : (pi != null ? pi.versionName : ""));

        Object versionCode = implementation.getBuildConfigValue(context, "VERSION_CODE");
        ret.put("versionCode", versionCode != null ? versionCode : (pi != null ? pi.versionCode : 0));

        Object debug = implementation.getBuildConfigValue(context, "DEBUG");
        ret.put("debug", debug != null ? (Boolean) debug : false);

        Object buildType = implementation.getBuildConfigValue(context, "BUILD_TYPE");
        ret.put("buildType", buildType != null ? buildType.toString() : "");

        Object flavor = implementation.getBuildConfigValue(context, "FLAVOR");
        ret.put("flavor", flavor != null ? flavor.toString() : "");

        // Build Date (if available in BuildConfig via custom Gradle task, otherwise empty)
        Object buildDate = implementation.getBuildConfigValue(context, "_BUILDINFO_TIMESTAMP");
        if (buildDate != null) {
            ret.put("buildDate", implementation.formatDate((Long) buildDate));
        } else {
            ret.put("buildDate", "");
        }

        if (pi != null) {
            ret.put("installDate", implementation.formatDate(pi.firstInstallTime));
        } else {
            ret.put("installDate", "");
        }

        call.resolve(ret);
    }
}
