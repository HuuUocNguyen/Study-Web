<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>


<!-- controller js: control data from api -->
<script>
	var app = angular.module("myapp", []);

	app.controller("tableController", [
			'$scope',
			'$http',
			function($scope, $http) {
				$scope.isCreate=true;
				
				var method = "";
				fetchAllCustomers();

				$scope.listCustomers = [];
				function fetchAllCustomers() {
					$http({
						method : "GET",
						url : "http://localhost:8080/SpringMVCHello/list"
					}).then(function successCallback(response) {
						// this callback will be called asynchronously
						// when the response is available
						$scope.listCustomers = response.data;
						console.log(response);
					}, function errorCallback(response) {
						// called asynchronously if an error occurs
						// or server returns response with an error status.
						console.log(response);
					});
				}

				$scope.deleteRow = function(i) {
					if (confirm('Are you sure you want to delete this?')) {
						//$scope.listCustomers.splice(i, 1);
						$http({
							method : "DELETE",
							url : "http://localhost:8080/SpringMVCHello/delete/"+i

						}).then(function successCallback(response) {
							// this callback will be called asynchronously
							// when the response is available
							console.log(response);
							fetchAllCustomers();
							
						}, function errorCallback(response) {
							// called asynchronously if an error occurs
							// or server returns response with an error status.
							console.log(response);
						});
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

			                $http({
								method : "PUT",
								url : "http://localhost:8080/SpringMVCHello/update",
								data : angular.toJson(element)

							}).then(function successCallback(response) {
								// this callback will be called asynchronously
								// when the response is available
								fetchAllCustomers();
								console.log(response);
							}, function errorCallback(response) {
								// called asynchronously if an error occurs
								// or server returns response with an error status.
								console.log(response);
							});
			            }
			        }
			        $scope.id = "";
			        $scope.name = "";
			        $scope.address = "";
			        $scope.isCreate=true;
			    }
				
				$scope.addRow = function() {
					for (let i = 0; i <  $scope.listCustomers.length; i++) {
           				var element = $scope.listCustomers[i];
           				if (element.id == $scope.id) { //  $scope.id là biến toàn cục khi updateRow lấy id ra
               				alert("Đã tồn tại id");
               				return;
           				}
       				}
					if ($scope.id == undefined || $scope.name == undefined
							|| $scope.address == undefined) {
						alert("input không được để trống");
					} else if ($scope.id != undefined
							&& $scope.name != undefined
							&& $scope.address != undefined) {
						var customer = {}; // type data now is json (object), not is array
						customer.id = $scope.id;
						customer.name = $scope.name;
						customer.address = $scope.address;

						$http({
							method : "POST",
							url : "http://localhost:8080/SpringMVCHello/add",
							data : angular.toJson(customer)

						}).then(function successCallback(response) {
							// this callback will be called asynchronously
							// when the response is available
							fetchAllCustomers();
							console.log(response);
						}, function errorCallback(response) {
							// called asynchronously if an error occurs
							// or server returns response with an error status.
							console.log(response);
						});

					}
				};
			} ]);
</script>

<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

form {
	border: 3px solid #f1f1f1;
}

input[type=text], input[type=number], input[type=password] {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	box-sizing: border-box;
}

input[type=submit] {
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
}

button {
	background-color: #4CAF50;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	cursor: pointer;
	width: 100%;
}

button:hover {
	opacity: 0.8;
}

.cancelbtn {
	width: auto;
	padding: 10px 18px;
	background-color: #f44336;
}

.imgcontainer {
	text-align: center;
	margin: 24px 0 12px 0;
}

img.avatar {
	width: 40%;
	border-radius: 50%;
}

.container {
	padding: 16px;
}

span.psw {
	float: right;
	padding-top: 16px;
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
	span.psw {
		display: block;
		float: none;
	}
	.cancelbtn {
		width: 100%;
	}
}
</style>


</head>

<!--ng-app="myApp" ng-controller="myController" để bao cả body (trong đó có table)-->

<body ng-app="myapp" ng-controller="tableController">

	<h2 style="text-align: center">Management Customer</h2>

	<form>
		<div class="container">
			<label for="id"><b>Id</b></label> <input type="text" ng-model="id" ng-disabled="!isCreate"
				placeholder="id" name="id" required> <label for="name"><b>Name</b></label>
			<input input type="text" ng-model="name" placeholder="name"
				name="name" required> <label for="address"><b>Address</b></label>

			<input input type="text" ng-model="address" placeholder="address"
				name="address" required>

			<button ng-click="addRow()"> Add</button></li> </br></br>
            <button ng-click="updateToTable()"> Update</button></li>

		</div>


	</form>
	<div class="container">
		<h2 style="text-align: center">List Customer</h2>
		<br />
		<table class="table table-bordered data-table">
			<thead>
				<tr>
					<th>Id</th>
					<th>Name</th>
					<th>Address</th>
					<th width="200px">Action</th>
				</tr>
			</thead>
			<tbody>
				<!--ng-repeat giong nhu 1 vong lap for-->
				<tr ng-repeat="customers in listCustomers">
					<td><label>{{customers.id}}</label></td>
					<td><label>{{customers.name}}</label></td>
					<td><label>{{customers.address}}</label></td>

					<td><input class='btn btn-danger'
						ng-click="updateRow(customers.id, customers.name, customers.address)"
						value="Edit" type="submit" /> <input class='btn btn-danger'
						ng-click="deleteRow(customers.id)" value="Delete" type="submit"
						style="background-color: crimson;" />
				</tr>
			</tbody>
		</table>
	</div>
</body>

</html>