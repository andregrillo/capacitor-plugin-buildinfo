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

        // VERSION_NAME - prefer BuildConfig, fallback to PackageInfo
        Object version = implementation.getBuildConfigValue(context, "VERSION_NAME");
        ret.put("version", version != null ? version.toString() : (pi != null ? pi.versionName : ""));

        // VERSION_CODE - prefer BuildConfig, fallback to PackageInfo
        Object versionCode = implementation.getBuildConfigValue(context, "VERSION_CODE");
        if (versionCode != null) {
            ret.put("versionCode", versionCode);
        } else if (pi != null) {
            ret.put("versionCode", String.valueOf(pi.versionCode));
        } else {
            ret.put("versionCode", "0");
        }

        // DEBUG - try BuildConfig, but also check via ApplicationInfo flags as fallback
        Object debug = implementation.getBuildConfigValue(context, "DEBUG");
        if (debug == null) {
            // Fallback: check if app is debuggable via ApplicationInfo
            try {
                android.content.pm.ApplicationInfo ai = context.getPackageManager().getApplicationInfo(packageName, 0);
                debug = (ai.flags & android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE) != 0;
            } catch (Exception e) {
                debug = false;
            }
        }
        ret.put("debug", debug);

        // BUILD_TYPE - prefer BuildConfig, fallback to empty
        Object buildType = implementation.getBuildConfigValue(context, "BUILD_TYPE");
        ret.put("buildType", buildType != null ? buildType.toString() : "");

        // FLAVOR - prefer BuildConfig, fallback to empty
        Object flavor = implementation.getBuildConfigValue(context, "FLAVOR");
        ret.put("flavor", flavor != null ? flavor.toString() : "");

        // Build Date - try BuildConfig _BUILDINFO_TIMESTAMP, fallback to packageInfo lastUpdateTime or current time
        Object buildDate = implementation.getBuildConfigValue(context, "_BUILDINFO_TIMESTAMP");
        if (buildDate != null) {
            ret.put("buildDate", implementation.formatDate((Long) buildDate));
        } else if (pi != null && pi.lastUpdateTime > 0) {
            ret.put("buildDate", implementation.formatDate(pi.lastUpdateTime));
        } else {
            ret.put("buildDate", implementation.formatDate(System.currentTimeMillis()));
        }

        // Install Date - use firstInstallTime from PackageInfo
        if (pi != null && pi.firstInstallTime > 0) {
            ret.put("installDate", implementation.formatDate(pi.firstInstallTime));
        } else {
            ret.put("installDate", "");
        }

        call.resolve(ret);
    }
}