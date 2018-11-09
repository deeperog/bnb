<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function() {
			$('input:checkbox').change(function() {
				var check = '';
				$('input:checkbox').each(function() {
					if ($(this).is(':checked')) {
						check = check + 'T';
					} else {
						check = check + 'F';
					}
				});
				$('#amenities').val(check);
			});

		});
	</script>
	<%@ include file="/resources/common/Navbar.jsp"%>
	<!-- Begin page content -->
	<!-- https://shaack.com/projekte/bootstrap-input-spinner/ -->
	<main role="main" class="container">
	<div class="row justify-content-md-center">
		<div class="col col-md-10 col-lg-8">
			<h1>
				<b>숙소 보기</b>
			</h1>
			<form method="post">
				<table class="table">
					<tr>
						<td>호스트 아이디</td>
						<td>${selectedRoom.hostId}</td>
					</tr>
					<tr>
						<td>소개</td>
						<td>${selectedRoom.details}</td>
					</tr>
					<tr>
						<td>인원</td>
						<td><c:if test="${0 ne selectedRoom.avail_adults}">
						어른 ${selectedRoom.avail_adults}명</c:if> <c:if
								test="${0 ne selectedRoom.avail_children}">
						어린이 ${selectedRoom.avail_children}명</c:if> <c:if
								test="${0 ne selectedRoom.avail_infants}">
						유아 ${selectedRoom.avail_infants}명</c:if></td>

					</tr>
					<tr>
						<td>시설</td>
						<td><c:if test="${0 ne selectedRoom.avail_bedroom}">
						침실 ${selectedRoom.avail_bedroom}개</c:if> <c:if
								test="${0 ne selectedRoom.avail_bed}">
						침대 ${selectedRoom.avail_bed}개</c:if> <c:if
								test="${0 ne selectedRoom.avail_bathroom}">
						욕실 ${selectedRoom.avail_bathroom}개</c:if></td>

					</tr>
					<tr>
						<td>편의시설</td>
						<td><c:set var="count" value="0" /> <c:set var="divideChk"
								value="1" /> <c:forEach items="${amenities}" var="item">
								<c:set var="count" value="${count+1}" />
								<c:if
									test="${'T' eq fn:substring(selectedRoom.amenities, count-1, count)}">
									<label for="amcb${count}" class="form-check-label">${item.amenities_details}</label>
									<c:if
										test="${divideChk ne (item.amenities_idx-(item.amenities_idx mod 100))/100}">
										<hr>
										<c:set var="divideChk"
											value="${(item.amenities_idx-(item.amenities_idx mod 100))/100}" />
									</c:if>
								</c:if>
							</c:forEach><input type="hidden" class="form-control"
							value="${selectedRoom.amenities}" id="amenities" name="amenities"></td>
					</tr>
					<tr>
						<td>체크인</td>
						<td>${selectedRoom.time_checkin}</td>
					</tr>
					<tr>
						<td>체크아웃</td>
						<td>${selectedRoom.time_checkout}</td>
					</tr>
					<tr>
						<td>주중가격</td>
						<td>${selectedRoom.price_weekdays}</td>
					</tr>
					<tr>
						<td>주말가격</td>
						<td>${selectedRoom.price_weekend}</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>${selectedRoom.address}</td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="input-group mb-3">
								<div class="custom-file">
									<input type="file" class="custom-file-input"
										id="inputGroupFile02"> <label
										class="custom-file-label" for="inputGroupFile02"
										aria-describedby="inputGroupFileAddon02">Choose file</label>
								</div>
								<div class="input-group-append">
									<span class="input-group-text" id="inputGroupFileAddon02">Upload</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="text-center"><input type="hidden"
							id="roomsId" name="${selectedRoom.roomsId}" value="0"><input
							type="hidden" id="disabled" name="disabled"
							value="${selectedRoom.disabled}"><input type="submit"
							class="btn btn-danger" value="수정"><a
							href="${pageContext.request.contextPath}/chat/sendmessage?roomsId=${selectedRoom.roomsId}&hostId=${selectedRoom.hostId}"><input
								type="button" class="btn btn-danger" value="문의하기"></a></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	</main>
</body>
</html>