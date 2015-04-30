app.factory("Procedure", ["$routeParams", "$parse", "$http", function ($routeParams, $parse, $http) {
    function Procedure(Options) {

        var self = this;

        var Config = { Name: Options.Name, Parameters: [] };
        Config.UserId = asqlBoolean(Options.UserId);
        Config.Type = asqlRestrict(Options.Type, ["singleton", "array", "object"], "execute");
        Config.Root = (Config.Type === "object") ? asqlIfBlank(Options.Root, null) : null;
        Config.ngModel = (Config.Type === "execute") ? null : Options.ngModel;
        if (angular.isFunction(Options.Success)) Config.Success = Options.Success;
        if (angular.isFunction(Options.Error)) Config.Error = Options.Error;

        self.AddParameter = function (Parameter) {
            var Name = asqlIfBlank(Parameter.Name, null);
            var Type = asqlRestrict(Parameter.Type, ["route", "scope"], "value")
            var Value = asqlIfBlank(Parameter.Value, (Type === "value") ? null : Name);
            var Required = asqlBoolean(Parameter.Required);
            Config.Parameters.push({ Name: Name, Type: Type, Value: Value, Required: Required });
        };

        angular.forEach(Options.Parameters, function (Item) { self.AddParameter(Item); });

        self.PostData = function (Scope) {
            var Data = { Name: Config.Name, Parameters: [], UserId: Config.UserId, Type: Config.Type }, HasRequired = true;
            Data.Token = Scope.$localStorage.Token;
            angular.forEach(Config.Parameters, function (Item) {
                var Parameter = { Name: Item.Name }, Value = null;
                switch (Item.Type) {
                    case "route": Value = $routeParams[Item.Value]; break;
                    case "scope": Value = $parse(Item.Value)(Scope); break;
                    default: Value = Item.Value; break;
                };
                if (asqlIsBlank(Value)) { if (Item.Required === true) HasRequired = false; }
                if (angular.isObject(Value)) {
                    Value = { Data: Value };
                    Parameter.XML = true;
                };
                Parameter.Value = asqlIfBlank(Value, null);
                Data.Parameters.push(Parameter);
            });
            return (HasRequired === true) ? Data : null;
        };

        self.Empty = function () {
            switch (Config.Type) {
                case "execute": return null; break;
                case "array": return []; break;
                default: return {}; break;
            };
        };

        self.Execute = function (Scope) {
            var ngModel = null;
            if (!asqlIsBlank(Config.ngModel)) {
                ngModel = $parse(Config.ngModel);
                ngModel.assign(Scope, self.Empty());
            };
            var PostData = self.PostData(Scope);
            if (!asqlIsBlank(PostData)) {
                $http.post("exec.ashx", PostData)
                    .success(function (Data) {
                        var Result = self.Empty();
                        if (Config.Type !== "execute") {
                            if (!asqlIsBlank(Data)) {
                                if (angular.isArray(Data)) { switch (Config.Type) { case "array": Result = Data; break; default: Result = Data[0]; break; }; }
                                else if (angular.isObject(Data)) { switch (Config.Type) { case "array": Result = [Data]; break; default: Result = Data; break; }; }
                                if (Config.Type === "object" && !asqlIsBlank(Config.Root)) Result = Result[Config.Root];
                            }
                        }
                        if (angular.isFunction(ngModel)) ngModel.assign(Scope, Result);
                        if (angular.isFunction(Config.Success)) Config.Success(Result);
                    })
                    .error(function (Response, Status) {
                        if (Status === 401) {
                            Scope.Logout();
                            Scope.Login(Response,
                                function () { self.Execute(Scope); },
                                function () { if (angular.isFunction(Config.Error)) Config.Error(Response, Status); });
                        }
                        else if (angular.isFunction(Config.Error)) Config.Error(Response, Status);
                    });
            }
        };

        self.AutoExec = function (Scope) {
            self.Execute(Scope);
            angular.forEach(Config.Parameters, function (Item) {
                if (Item.Type === "scope") { Scope.$watch(Item.Value, function (newValue, oldValue) { if (newValue !== oldValue) { self.Execute(Scope); } }); };
            });
        };

    };
    return Procedure;
}]);