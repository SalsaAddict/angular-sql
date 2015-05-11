app.controller("SectionController", ["$scope", "$routeParams", "$route", "Procedure", function ($scope, $routeParams, $route, Procedure) {

    var self = this;

    self.ReIndexCarriers = function () {
        var Index = 0;
        angular.forEach($scope.Section.Carriers, function (Item) {
            Item.Index = Index;
            Index++;
        });
    };

    $scope.BinderId = $routeParams.BinderId;

    var apiSection = new Procedure({
        Name: "apiBinderSection", UserId: true, Type: "object", Root: "Section", ngModel: "Section",
        Parameters: [{ Name: "SectionId", Type: "route", Required: true }],
        Success: function () { self.ReIndexCarriers(); }
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
        self.ReIndexCarriers();
        $scope.asqlForm.setDirty();
    };

    $scope.AddCarrier = function () {
        if (!angular.isDefined($scope.Section.Carriers)) $scope.Section.Carriers = [];
        $scope.Section.Carriers.push({ CarrierId: null, Percentage: 0 });
        self.ReIndexCarriers();
        $scope.asqlForm.setDirty();
    };

    $scope.Total = function () {
        var Total = 0;
        angular.forEach($scope.Section.Carriers, function (Item) { Total += parseFloat(Item.Percentage); });
        $scope.TotalCheck = (Total === 1) ? true : null;
        return Total;
    };

    $scope.Save = new Procedure({
        Name: "apiBinderSectionSave", UserId: true, Type: "object", Root: "Section", ngModel: "Section",
        Parameters: [
            { Name: "SectionId", Type: "route" },
            { Name: "BinderId", Type: "scope", Required: true },
            { Name: "ClassId", Type: "scope", Value: "Section.ClassId" },
            { Name: "Title", Type: "scope", Value: "Section.Title" },
            { Name: "AdministratorId", Type: "scope", Value: "Section.AdministratorId" },
            { Name: "Carriers", Type: "scope", Value: "Section.Carriers" }
        ],
        Success: function (Data) {
            if (!$routeParams.SectionId) $route.updateParams({ BinderId: Data.BinderId, SectionId: Data.SectionId });
        }
    });

}]);