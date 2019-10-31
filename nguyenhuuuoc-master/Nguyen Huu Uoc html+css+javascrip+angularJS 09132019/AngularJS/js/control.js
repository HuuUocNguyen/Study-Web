var app = angular.module("myapp", []);

app.controller("tableController", ['$scope', function ($scope) {

    $scope.isCreate=true;

    // JSON ARRAY TO TABLE.
    $scope.listCustomers = [{
        'id': '7',
        'name': 'Eden Hazard',
        'address': 'RealMadrid'
    }, {
        'id': '44',
        'name': 'Mike Tyson',
        'address': 'Los A, US'
    }, {
        'id': '10',
        'name': 'Neymer',
        'address': 'Brazil'

    }];
    // delete function this remove the selected table row
    $scope.deleteRow = function (i) {
        if (confirm('Are you sure you want to delete this?')) {
            $scope.listCustomers.splice(i, 1);
        }

    };

    // get data from button edit
    $scope.updateRow = function(id, name, address) {
        $scope.id = id;
        $scope.name = name;
        $scope.address = address;
        $scope.isCreate=false;
    }
    // hoặc cách khác: hàm update = delte + add
    $scope.updateToTable = function(){
        for (let i = 0; i <  $scope.listCustomers.length; i++) {
            var element = $scope.listCustomers[i];
            if (element.id == $scope.id) { //  $scope.id là biến toàn cục khi updateRow lấy id ra
                element.name = $scope.name;
                element.address = $scope.address;
            }
        }

        $scope.id = "";
        $scope.name = "";
        $scope.address = "";
        $scope.isCreate=true;
    }
    $scope.addRow = function () {
        for (let i = 0; i <  $scope.listCustomers.length; i++) {
            var element = $scope.listCustomers[i];
            if (element.id == $scope.id) { //  $scope.id là biến toàn cục khi updateRow lấy id ra
                alert("Đã tồn tại id");
                return;
            }
        }
        if ($scope.id == undefined || $scope.name == undefined || $scope.address == undefined) {
            alert("input không được để trống");
        }

        else if ($scope.id != undefined && $scope.name != undefined && $scope.address != undefined) {

            var customer = [];
            customer.id = $scope.id;
            customer.name = $scope.name;
            customer.address = $scope.address;

            $scope.listCustomers.push(customer);


        }
    };

}]);