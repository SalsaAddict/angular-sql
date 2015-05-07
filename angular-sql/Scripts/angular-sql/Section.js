app.controller("SectionController", ["$scope", "Procedure", function ($scope, Procedure) {

    var apiSection = new Procedure({
        Name: "apiBinderSection", UserId: true, Type: "object", Root: "Section", ngModel: "Section",
        Parameters: [{ Name: "SectionId", Type: "route", Required: true }]
    });
    apiSection.Execute($scope);

    var apiClass = new Procedure({ Name: "apiClassOfBusiness", UserId: true, Type: "array", ngModel: "Classes" });
    apiClass.Execute($scope);

    var apiAdministrators = new Procedure({
        Name: "apiBinderSectionAdministrator", UserId: true, Type: "array", ngModel: "Administrators",
        Parameters: [{ Name: "SectionId", Type: "route" }]
    });
    apiAdministrators.Execute($scope);

    var apiCarriers = new Procedure({
        Name: "apiBinderSectionCarrier", UserId: true, Type: "array", ngModel: "Carriers",
        Parameters: [{ Name: "BinderId", Type: "route" }]
    });
    apiCarriers.Execute($scope);

    $scope.CarrierLabel = function (Index) {
        switch (Index) {
            case 0: return "Lead"; break;
            case 1: return "Second"; break;
            default: return "Other"; break;
        };
    };

    $scope.RemoveCarrier = function (Item) {
        var Index = $scope.Section.Carriers.indexOf(Item);
        $scope.Section.Carriers.splice(Index, 1);
        $scope.asqlForm.setDirty();
    };

    $scope.AddCarrier = function () {
        if (!angular.isDefined($scope.Section.Carriers)) $scope.Section.Carriers = [];
        $scope.Section.Carriers.push({ CarrierId: null, Percentage: (1 - $scope.Total()) });
        $scope.asqlForm.setDirty();
    };

    $scope.Total = function () {
        var Total = 0;
        angular.forEach($scope.Section.Carriers, function (Item) { Total += parseFloat(Item.Percentage); });
        $scope.TotalCheck = (Total === 1) ? true : null;
        return Total;
    };

    $scope.Save = {};

}]);