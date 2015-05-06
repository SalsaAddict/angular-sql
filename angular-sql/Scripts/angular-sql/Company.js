app.controller("CompaniesController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiCompanies = new Procedure({ Name: "apiCompanies", UserId: true, Type: "array", ngModel: "Companies" });
    apiCompanies.Execute($scope);

}]);

app.controller("CompanyController", ["$scope", "$route", "$routeParams", "Procedure", function ($scope, $route, $routeParams, Procedure) {

    var apiCompany = new Procedure({
        Name: "apiCompany", UserId: true, Type: "singleton", ngModel: "Company",
        Parameters: [{ Name: "CompanyId", Type: "route", Required: true }]
    });
    apiCompany.Execute($scope);

    var apiCompanyRoles = new Procedure({
        Name: "apiCompanyRoles", Type: "array", ngModel: "Roles",
        Success: function () {
            angular.forEach($scope.Roles, function (Item) {
                $scope.Save.AddParameter({ Name: Item.Id, Type: "scope", Value: "Company." + Item.Id })
            });
        }
    });
    apiCompanyRoles.Execute($scope);

    var apiCountries = new Procedure({ Name: "apiCountries", Type: "array", ngModel: "Countries" });
    apiCountries.Execute($scope);

    $scope.Save = new Procedure({
        Name: "apiCompanySave", UserId: true, Type: "singleton",
        Parameters: [
            { Name: "CompanyId", Type: "route" },
            { Name: "Name", Type: "scope", Value: "Company.Name", Required: true },
            { Name: "Address", Type: "scope", Value: "Company.Address" },
            { Name: "Postcode", Type: "scope", Value: "Company.Postcode" },
            { Name: "CountryId", Type: "scope", Value: "Company.CountryId", Required: true }
        ],
        Success: function (Data) {
            $scope.Company = Data;
            $route.updateParams({ CompanyId: Data.CompanyId });
        }
    });

    $scope.Delete = new Procedure({
        Name: "apiCompanyDelete", UserId: true,
        Parameters: [{ Name: "CompanyId", Type: "scope", Value: "Company.CompanyId", Required: true }]
    });

}]);