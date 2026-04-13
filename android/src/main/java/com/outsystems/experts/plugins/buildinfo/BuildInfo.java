package com.outsystems.experts.plugins.buildinfo;

import com.getcapacitor.Logger;

public class BuildInfo {

    public String echo(String value) {
        Logger.info("Echo", value);
        return value;
    }
}
