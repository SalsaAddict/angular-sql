app.directive("asqlForm", ["$interpolate", "$parse", "$window", "$location", "$route", function ($interpolate, $parse, $window, $location, $route) {
    return {
        restrict: "E",
        templateUrl: "controls/asqlForm.html",
        transclude: true,
        scope: false,
        controller: function ($scope) {
            $scope.asqlForm = { alert: null };
            this.canEdit = $scope.asqlForm.canEdit = function () { return angular.isDefined($scope.Save); };
            this.formDirty = function () { return $scope.asqlFormX.$dirty; };
            $scope.$on("$routeChangeStart", function (event) {
                if ($scope.asqlFormX.$dirty) {
                    $scope.Error("Please save or undo your changes first.");
                    event.preventDefault();
                };
            });
        },
        link: {
            pre: function (scope, iElement, iAttrs, controller) {
                scope.asqlForm.setDirty = function () { scope.asqlFormX.$setDirty(); };
                scope.asqlForm.dismissAlert = function () { scope.asqlForm.alert = null };
                scope.asqlForm.heading = function () { return $interpolate(iAttrs["heading"])(scope); };
                scope.asqlForm.editing = function () { return scope.asqlForm.canEdit() && scope.asqlFormX.$dirty; };
                scope.asqlForm.hasError = function () { return scope.asqlForm.editing() && scope.asqlFormX.$invalid; };
                scope.asqlForm.back = function () { if (iAttrs["back"]) $location.path(iAttrs["back"]); else $window.history.back(); };
                scope.asqlForm.undo = function () { scope.asqlFormX.$setPristine(); $route.reload(); };
                scope.asqlForm.save = function () {
                    scope.Save.Execute(scope)
                        .success(function (data) {
                            scope.Success("Your changes were saved successfully.");
                            scope.asqlFormX.$setPristine();
                        })
                        .error(function (response, status) { scope.Error(response); });
                };
            }
        }
    };
}]);

app.directive("asqlSubForm", [function () {
    return {
        restrict: "A",
        require: ["form", "^^asqlForm"],
        scope: true,
        link: function (scope, iElement, iAttrs, controller) {
            iElement.attr("novalidate", true);
            scope.formDirty = function () { return controller[1].formDirty(); };
            scope.hasError = function () { return scope.formDirty() && controller[0].$invalid; };
        }
    };
}]);

app.directive("asqlLabel", [function () {
    return {
        restrict: "E",
        templateUrl: "controls/asqlLabel.html",
        transclude: true,
        scope: { text: "@" }
    };
}]);

app.directive("asqlControl", ["$filter", function ($filter) {
    return {
        restrict: "A",
        require: ["^^asqlForm", "ngModel"],
        link: function (scope, iElement, iAttrs, controller) {
            if (!iElement.hasClass("form-control") && iElement.prop("type") !== "checkbox") iElement.addClass("form-control");
            if (iElement.prop("type") === "date") {
                controller[1].$formatters.push(function (modelValue) { return new Date(modelValue); });
                controller[1].$parsers.push(function (modelValue) { return $filter("date")(new Date(modelValue), "yyyy-MM-dd"); });
            };
            if (iAttrs["asqlControl"]) {
                switch (angular.lowercase(iAttrs["asqlControl"])) {
                    case "percent":
                        controller[1].$formatters.push(function (modelValue) { return parseFloat(modelValue) * 100; });
                        controller[1].$parsers.push(function (modelValue) { return parseFloat(modelValue) / 100; });
                        break;
                };
            };
            if (!controller[0].canEdit()) iElement.attr("disabled", true);

        }
    };
}]);
