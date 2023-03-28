<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register Page</title>


<!--css-->
<%@include file="includes/allCss.jsp"%>
</head>
<body>
	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>" />
	<%@include file="/includes/navbar.jsp"%>

	<main class="div-color " style="padding-bottom: 80px;">

		<div class="container">

			<div class="col-md-6 offset-md-3">

				<div class="card">
					<div class="card-header text-center primary-background text-white">
						<span class="fa fa-3x fa-user-circle"></span> <br> Register
						here
					</div>
					<div class="card-body">
						<form class="mt-4" id="reg-form"
							action="newa" method="POST">

							<div class="form-group">
								<label for="user_name">User Name</label> <input name="user_name"
									type="text" class="form-control" id="user_name"
									aria-describedby="emailHelp" placeholder="Enter name"
									required="required">
							</div>

							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									name="user_email" type="email" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									placeholder="Enter email" required="required"> <small
									id="emailHelp" class="form-text text-muted">We'll never
									share your email with anyone else.</small>
							</div>



							<div class="form-group">
								<label for="exampleInputPassword1">Password</label> <input
									name="user_password" type="password" class="form-control"
									id="exampleInputPassword1" placeholder="Password"
									required="required">
							</div>


							<div class="form-group">
								<label for="gender">Select Gender</label> <br> <input
									type="radio" id="gender" name="gender" value="male">Male
								<input type="radio" id="gender" name="gender" value="famale">Female
							</div>

							<div class="form-group">

								<textarea name="about" class="form-control" id="" rows="5"
									placeholder="Enter something about yourself"></textarea>

							</div>


							<div class="form-check">
								<input name="check_1" type="checkbox" class="form-check-input"
									id="exampleCheck1" required="required"> <label
									class="form-check-label" for="exampleCheck1">agree
									terms and conditions</label>
							</div>

							<br>

							<div class="container text-center" id="loader"
								style="display: none;">
								<span class="fa fa-refresh fa-spin fa-4x"></span>
								<h4>Please wait..</h4>
							</div>

							<button id="sumbimt-btn" type="submit" class="btn btn-primary">Submit</button>
						</form>

					</div>


				</div>




			</div>
		</div>

	</main>


	<!--javascripts-->

	<!-- <script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
		    <script>
         document.addEventListener('DOMContentLoaded', function () {
            console.log('loaded........');
            var submitBtn = document.querySelector('#sumbimt-btn');
            var form = document.querySelector('form#reg-form');
            var loader = document.querySelector('#loader');

            submitBtn.addEventListener('click', function (event) {
                event.preventDefault();
                submitBtn.style.display = 'none';
                loader.style.display = 'block';

                var xhr = new XMLHttpRequest();
                xhr.open('POST', 'newa', true);

                xhr.onload = function () {
                    if (xhr.status >= 200 && xhr.status < 400) {
                        var data = xhr.responseText;
                        console.log(data);
                        submitBtn.style.display = 'block';
                        loader.style.display = 'none';

                        if (data.trim() === 'done') {
                            swal('Registered successfully..We are going to redirect to login page')
                                .then((value) => {
                                    window.location = 'login_page.jsp';
                                });
                        } else {
                            swal(data);
                        }
                    } else {
                        submitBtn.style.display = 'block';
                        loader.style.display = 'none';
                        swal('something went wrong..try again');
                    }
                };

                xhr.onerror = function () {
                    submitBtn.style.display = 'block';
                    loader.style.display = 'none';
                    swal('something went wrong..try again');
                };

                xhr.send(new FormData(form));
            });
        });

        </script> -->

	<script type="text/javascript">
		var status = document.getElementById("status").value;
		console.log(status);
		if (status == "success") {
			swal("congrats", "Account Created successfull", "success")
		} else if (status == "failed") {
			swal("faild", "Account alerdy creade", "error")

		}
	</script>
	<%@include file="/includes/footer.jsp"%>
</body>
</html>