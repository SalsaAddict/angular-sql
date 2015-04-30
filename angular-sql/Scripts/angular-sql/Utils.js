function asqlIsBlank(Value) {
    if (Value === undefined) return true;
    else if (Value === null) return true;
    else if (Value.toString().trim().length === 0) return true;
    else return false;
};

function asqlIfBlank(Value, DefaultValue) {
    return (asqlIsBlank(Value)) ? DefaultValue : Value;
};

function asqlRestrict(Value, AllowedValues, DefaultValue) {
    if (!asqlIsBlank(Value)) { if (AllowedValues.indexOf(Value) >= 0) { return Value; } }
    return asqlIfBlank(DefaultValue, null);
};

function asqlBoolean(Value) {
    return !asqlIsBlank(asqlRestrict(asqlIfBlank(Value, "").toString().trim().toLowerCase(), ["true", "t", "yes", "y", "1", "-1"]));
};