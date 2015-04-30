app.directive("asqlForm", function () {
    return {
        restrict: "A",
        require: ["form", "^^?form"],
        scope: true,
        link: function (scope, iElement, iAttrs, controller) {
            if (!iElement.hasClass("form-horizontal")) iElement.addClass("form-horizontal");
            iElement.attr("novalidate", true);
            scope.HasError = function () { return asqlIfBlank(controller[1], controller[0]).$dirty && controller[0].$invalid; };
        }
    };
});

app.directive("asqlLabel", function () {
    return {
        restrict: "E",
        templateUrl: "controls/asqlLabel.html",
        scope: { Text: "@text" },
        transclude: true
    };
});

app.directive("asqlControl", function () {
    return {
        restrict: "A",
        link: function (scope, iElement, iAttrs, controller) {
            if (!iElement.hasClass("form-control")) iElement.addClass("form-control");
        }
    };
});

app.directive("asqlButtons", ["$window", "$location", "$route", function ($window, $location, $route) {
    return {
        restrict: "E",
        require: "^^form",
        templateUrl: "controls/asqlButtons.html",
        scope: { back: "@", Save: "&save", Undo: "&undo", Delete: "&delete" },
        controller: function ($scope) {
            $scope.Back = function () { if ($scope.back) { $location.path($scope.back); } else { $window.history.back(); } };
        },
        link: function (scope, iElement, iAttrs, controller) {
            scope.Dirty = function () { return controller.$dirty; };
            scope.CanEdit = function () { return angular.isDefined(iAttrs["save"]); };
            scope.ShowDelete = function () { return angular.isDefined(iAttrs["delete"]); };
            scope.Editing = function () { return scope.CanEdit() && scope.Dirty(); };
            scope.DisableSave = function () { return controller.$invalid; };
            if (!angular.isDefined(iAttrs["undo"])) scope.Undo = function () { $route.reload(); };
        }
    };
}]);
