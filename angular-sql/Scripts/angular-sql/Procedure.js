app.factory("Procedure", ["$http", function ($http) {
    function Procedure(Config) {

        var self = this;

        self.Config = {
            Name: Config.Name,
            Parameters: [],
            Type: asqlRestrict(Config.Type, ["singleton", "array", "object"], "execute"),
            UserId: asqlRestrict(Config.UserId, [true], false)
        };

        self.AddParameter = function (Parameter) {
            var Name = asqlIfBlank(Parameter.Name, null);
            var Type = asqlRestrict(Parameter.Type, ["route", "scope"], "value")
            var Value = asqlIfBlank(Parameter.Value, (Type === "value") ? null : Name);
            self.Config.Parameters.push({ Name: Name, Type: Type, Value: Value });
        };

        angular.forEach(Config.Parameters, function (Item) { self.AddParameter(Item); });

    };
    return Procedure;
}]);