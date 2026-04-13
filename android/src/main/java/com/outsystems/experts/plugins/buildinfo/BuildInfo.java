package com.outsystems.experts.plugins.buildinfo;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public class BuildInfo {

    public String getPackageName(Context context) {
        return context.getPackageName();
    }

    public String getDisplayName(Context context) {
        PackageManager pm = context.getPackageManager();
        return context.getApplicationInfo().loadLabel(pm).toString();
    }

    public PackageInfo getPackageInfo(Context context) {
        try {
            return context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
        } catch (PackageManager.NameNotFoundException e) {
            return null;
        }
    }

    public Object getBuildConfigValue(Context context, String fieldName) {
        try {
            Class<?> clazz = Class.forName(context.getPackageName() + ".BuildConfig");
            Field field = clazz.getField(fieldName);
            return field.get(null);
        } catch (Exception e) {
            try {
                // Try with base package if different
                String packageName = context.getPackageName();
                int lastDot = packageName.lastIndexOf('.');
                if (lastDot > 0) {
                    String basePackage = packageName.substring(0, lastDot);
                    Class<?> clazz = Class.forName(basePackage + ".BuildConfig");
                    Field field = clazz.getField(fieldName);
                    return field.get(null);
                }
            } catch (Exception e2) {
                // Ignore
            }
        }
        return null;
    }

    public String formatDate(long time) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ", Locale.US);
        return formatter.format(new Date(time));
    }
}
