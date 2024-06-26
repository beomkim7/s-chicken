<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>S치킨-그룹웨어</title>
<c:import url="../template/head.jsp" />
</head>

<body>
	<!-- ======= Header ======= -->
	<c:import url="../template/header.jsp" />
	<!-- ======= Sidebar ======= -->
	<c:import url="../template/sidebar.jsp" />
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>회원가입</h1>
		</div>
		<section class="section">
			<div class="row">
				<div class="col-12">
					<div class="card">
						<div class="card-body mt-3">
						
							<form class="d-flex flex-column align-items-center " action="./join" method="post" onsubmit="return submitForm()">

								<div class="row justify-content-center mb-3 w-50">
									<div class="form-group mb-3 mt-3">
										<label for="name" class="form-label"><b>이름</b></label> <input
											name="name" id="name" type="text" class="form-control" placeholder="이름">
									</div>
									<div class="form-group mb-3">
										<label for="phoneNumber" class="form-label"><b>전화번호</b></label>
										<input id="phoneNumber" name="phoneNumber" type="text" class="form-control"
											placeholder="'-' 제외하고 넣어주세요.">
									</div>
									<div class="form-group mb-3">
										<label for="email" class="form-label"><b>이메일</b></label> <input
											id="email" name="email" type="email" class="form-control"
											placeholder="이메일">
									</div>

									<label for="address" class="form-label"><b>주소</b></label>
									<div class="form-group mb-3 d-flex">
										<input type="text" id="postcode" name="postcode" placeholder="우편번호"
											class="form-control"> <input type="button"
											onclick="openPostcodePopup()" value="우편번호 찾기"
											class="btn btn-primary" name="">
									</div>

									<div class="form-group mb-3 d-flex">
										<input type="text" id="address" name="address" class="form-control"
											placeholder="주소"> <input type="text"
											id="addressDetail" name="addressDetail" class="form-control ml-2"
											placeholder="상세주소">
									</div>


									<div class="form-group mb-3 col-6">
										<label for="residentNumber" class="form-label"><b>생년월일</b></label>
										<input id="residentNumber" name="residentNumber" type="date" class="form-control">
									</div>
									<div class="form-group mb-3 col-6">
										<label for="dateOfEmployment" class="form-label"><b>입사일</b></label>
										<input id="dateOfEmployment"  name="dateOfEmployment" type="date" class="form-control">
									</div>
									<div class="form-group mb-3 col-11">
										<label for="salary" class="form-label"><b>연봉</b></label>
										<input id="salary"  name="salary" type="text" class="form-control" placeholder="만원 단위로 입력해주세요.">
									</div>
										<div class="col-1" style="margin-top: 38px; margin-left: -10px">만원</div>
									<div class="form-group mb-3 col-4">
										<label for="posId"  class="form-label"><b>직급</b></label> <select
											class="form-select" id="posId" name="posId">
											<option value="0">직급 선택</option>
											<option value="2">사원</option>
											<option value="3">주임</option>
											<option value="4">계장</option>
											<option value="5">대리</option>
											<option value="6">과장</option>
											<option value="7">차장</option>
											<option value="8">부장</option>
											<option value="9">감사</option>
											<option value="10">이사</option>
											<option value="11">상무</option>
											<option value="12">부사장</option>
											<option value="13">사장</option>
										</select>
									</div>
									<div class="form-group mb-3 col-4">
										<label for="department" class="form-label"><b>부서</b></label> <select
											class="form-select" id="department">
											<option value="0">부서 선택</option>

										</select>
									</div>
									<div class="form-group mb-3 col-4">
										<label for="team" class="form-label"><b>팀</b></label> <select
											class="form-select" id="team" name="departmentId">
											<option value="0">팀 선택</option>

										</select>
									</div>
									<div class="form-group mb-3 col-4">
										<label for="bankName" class="form-label"><b>은행명</b></label> <select
											class="form-select" id="bankName" name="bankName">
											<option value="0">은행 선택</option>
											<option value="국민은행">국민은행</option>
											<option value="신한은행">신한은행</option>
											<option value="농협">농협</option>
											<option value="신협">신협</option>
											<option value="기업은행">기업은행</option>
											<option value="카카오뱅크">카카오뱅크</option>
											<option value="토스뱅크">토스뱅크</option>
										</select>
									</div>
									<div class="form-group mb-3 col-8">
										<label for="accountNumber" class="form-label"><b>계좌번호</b></label>
										<input id="accountNumber" name="accountNumber" type="text" class="form-control"
											placeholder="계좌번호">
									</div>
								</div>


								<input type="hidden" id="password" name="password">
								<!-- <input type="file" name="attach" value="/static/img/기본.jpg"> -->
									
								<button type="submit" class="btn btn-primary mt-3">회원가입</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->
	<!-- ======= Footer ======= -->
	<c:import url="../template/footer.jsp" />
	<!-- ======= Script ======= -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="/js/employee/address.js"></script>
	<script src="/js/employee/department.js"> </script>
	<c:import url="../template/script.jsp" />
	<script>
    // 생년월일 입력 필드를 가져옴
    const residentNumberInput = document.getElementById("residentNumber");

    // 오늘 날짜를 구함
    const today = new Date();

    // 20년 전의 날짜를 계산하여 구함
    const maxDate = new Date(today.getFullYear() - 20, today.getMonth(), today.getDate());

    // 최대 날짜를 yyyy-mm-dd 형식으로 변환
    const maxDateString = maxDate.toISOString().split('T')[0];

    // 생년월일 입력 필드에 최대 날짜를 설정
    residentNumberInput.setAttribute("max", maxDateString);

    // 초기값을 20년 전으로 설정
    //residentNumberInput.value = maxDateString;
    
    
</script>
	
</body>

</html>