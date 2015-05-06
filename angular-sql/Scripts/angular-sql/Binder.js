app.controller("BindersController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiBinders = new Procedure({ Name: "apiBinders", UserId: true, Type: "array", ngModel: "Binders" });
    apiBinders.Execute($scope);

}]);

app.controller("BinderController", ["$scope", "$routeParams", "$route", "Procedure", function ($scope, $routeParams, $route, Procedure) {

    $scope.IsNew = function () { return asqlIsBlank($routeParams.BinderId); };

    var apiBinder = new Procedure({
        Name: "apiBinder", UserId: true, Type: "singleton", ngModel: "Binder",
        Parameters: [{ Name: "BinderId", Type: "route", Required: true }]
    });
    apiBinder.Execute($scope);

    var apiCoverholders = new Procedure({
        Name: "apiBinderCoverholder", UserId: true, Type: "array", ngModel: "Coverholders",
        Parameters: [{ Name: "BinderId", Type: "route" }]
    });
    apiCoverholders.Execute($scope);

    var apiBrokers = new Procedure({
        Name: "apiBinderBroker", UserId: true, Type: "array", ngModel: "Brokers",
        Parameters: [{ Name: "BinderId", Type: "route" }]
    });
    apiBrokers.Execute($scope);

    var apiTerritories = new Procedure({ Name: "apiTerritories", Type: "array", ngModel: "Territories" });
    apiTerritories.Execute($scope);

    var apiDomiciled = new Procedure({
        Name: "apiBinderDomiciled", UserId: true, Type: "singleton", ngModel: "Domiciled",
        Parameters: [
            { Name: "CoverholderId", Type: "scope", Value: "Binder.CoverholderId", Required: true },
            { Name: "DomiciledTerritoryId", Type: "scope", Value: "Binder.DomiciledTerritoryId", Required: true }
        ]
    });
    apiDomiciled.AutoExec($scope);

    var apiSections = new Procedure({
        Name: "apiBinderSections", UserId: true, Type: "array", ngModel: "Sections",
        Parameters: [{ Name: "BinderId", Type: "route", Required: true }]
    });
    apiSections.Execute($scope);

    $scope.Save = new Procedure({
        Name: "apiBinderSave",
        UserId: true, Type: "singleton",
        Parameters: [
            { Name: "BinderId", Type: "route" },
            { Name: "UMR", Type: "scope", Value: "Binder.UMR" },
            { Name: "Reference", Type: "scope", Value: "Binder.Reference" },
            { Name: "CoverholderId", Type: "scope", Value: "Binder.CoverholderId" },
            { Name: "BrokerId", Type: "scope", Value: "Binder.BrokerId" },
            { Name: "InceptionDate", Type: "scope", Value: "Binder.InceptionDate" },
            { Name: "ExpiryDate", Type: "scope", Value: "Binder.ExpiryDate" },
            { Name: "RisksTerritoryId", Type: "scope", Value: "Binder.RisksTerritoryId" },
            { Name: "DomiciledTerritoryId", Type: "scope", Value: "Binder.DomiciledTerritoryId" },
            { Name: "LimitsTerritoryId", Type: "scope", Value: "Binder.LimitsTerritoryId" }
        ],
        Success: function (Data) {
            $scope.Binder = Data;
            $route.updateParams({ BinderId: Data.BinderId });
        }
    });

}]);

app.controller("BinderxController", ["$scope", "$routeParams", "$route", "Procedure", function ($scope, $routeParams, $route, Procedure) {

    var New = (angular.lowercase($routeParams.BinderId) === "new");

    var apiCoverholders = new Procedure({ Name: "apiBinderCoverholder", UserId: true, Type: "array", ngModel: "Coverholders" });
    var apiBrokers = new Procedure({ Name: "apiBinderBroker", UserId: true, Type: "array", ngModel: "Brokers" });
    var apiTerritories = new Procedure({ Name: "apiTerritories", Type: "array", ngModel: "Territories" });

    if (New !== true) {
        var BinderIdParam = { Name: "BinderId", Type: "route", Required: true };
        var apiBinder = new Procedure({ Name: "apiBinder", UserId: true, Type: "singleton", ngModel: "Binder" });
        apiBinder.AddParameter(BinderIdParam);
        apiBinder.Execute($scope);
        apiCoverholders.AddParameter(BinderIdParam);
        apiBrokers.AddParameter(BinderIdParam);
    }
    else { $scope.Binder = {}; };

    apiCoverholders.Execute($scope);
    apiBrokers.Execute($scope);
    apiTerritories.Execute($scope);

    $scope.Save = new Procedure({
        Name: (New === true) ? "apiBinderInsert" : "apiBinderUpdate",
        UserId: true, Type: "singleton", ngModel: "Binder",
        Parameters: [
            { Name: "UMR", Type: "scope", Value: "Binder.UMR" },
            { Name: "Reference", Type: "scope", Value: "Binder.Reference" },
            { Name: "CoverholderId", Type: "scope", Value: "Binder.CoverholderId" },
            { Name: "BrokerId", Type: "scope", Value: "Binder.BrokerId" },
            { Name: "InceptionDate", Type: "scope", Value: "Binder.InceptionDate" },
            { Name: "ExpiryDate", Type: "scope", Value: "Binder.ExpiryDate" },
            { Name: "RisksTerritoryId", Type: "scope", Value: "Binder.RisksTerritoryId" },
            { Name: "DomiciledTerritoryId", Type: "scope", Value: "Binder.DomiciledTerritoryId" },
            { Name: "LimitsTerritoryId", Type: "scope", Value: "Binder.LimitsTerritoryId" }
        ],
        Success: function (Data) { $route.updateParams({ BinderId: Data.BinderId }); }
    });
    if (New !== true) $scope.Save.AddParameter({ Name: "BinderId", Type: "route" });

}]);