<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review</title>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>

	<div id="mypage_wrap_cont">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont">
			<ul class="nav reviewNav">
				<li class="nav-item"><a class="nav-link active"
					href="${pageContext.request.contextPath }/review">내가 쓴 후기</a></li>
				<li class="nav-item"><a class="nav-link" href="#">내게 쓴 후기</a></li>
				<li style="margin-left: 335px;">
					<form class="form-inline my-2 my-lg-0" method="get">
						<select class="custom-select" id="inputGroupSelect01"
							name="searchType">
							<option value="all"
								<c:out value="${rvs.searchType == null?'selected':''}" />>전체검색</option>
							<option value="reviewDate"
								<c:out value="${rvs.searchType eq 'reviewDate'?'selected':''}" />>날짜</option>
							<option value="hostId"
								<c:out value="${rvs.searchType eq 'hostId'?'selected':''}" />>호스트명</option>
							<option value="scope"
								<c:out value="${rvs.searchType eq 'scope'?'selected':''}" />>별점</option>
						</select>&ensp; <input class="form-control mr-sm-2" type="search"
							placeholder="검색하기" aria-label="Search" name="keyword"
							id="keywordInput" value="${rvs.keyword}">
						<button class="btn my-2 my-sm-0" id="searchBtn"
							style="background-color: #FF5675; color: white;">검색</button>
					</form>
				</li>
			</ul>
			<c:if test="${empty reviewSearch}">
				<h1 style="text-align: center; padding: 20px; font-weight: 800;">검색
					결과가 없습니다.</h1>
			</c:if>

			<div id="review_cont">
				<!-- 내가 쓴 것만 나타내줌! 리뷰쓴내역 -->
				<c:forEach var="res" items="${reviewSearch}">
					<c:if test="${res ne null}">
						<table id="review_table" rules="none" style="border-radius: 10px;">
							<tr>
								<td class="review_photo" rowspan='2'><img
									src="${pageContext.request.contextPath}/resources/images/짱짱절미.jpg"
									id="review_img"></td>
								<td class="review_host"><b>${res.hostId}</b>님의 대한 후기</td>
								<td><c:forEach var="scope" begin="1" end="${res.scope}">
										<i class="fas fa-star" style="color: #FF5675"></i>
									</c:forEach></td>
								<td
									style="text-align: right; padding-right: 10px; line-height: 40px;">
									<button type="button" class="btn btn-secondary btn-sm"
										onclick="javascript:location.href='${pageContext.request.contextPath}/reviewEdit?reservationNum=${res.reservationNum}'">수정</button>
									<!-- Button trigger modal -->
									<button type="button" class="btn btn-secondary btn-sm"
										data-toggle="modal" data-target="#deleteModal">삭제</button> <!-- Modal -->
									<div class="modal fade" id="deleteModal" tabindex="-1"
										role="dialog" aria-labelledby="deleteModal" aria-hidden="true">
										<div class="modal-dialog modal-dialog-centered"
											role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h5 class="modal-title" id="exampleModalCenterTitle">후기삭제</h5>
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
												</div>
												<div class="modal-body" style="text-align: center;">
													<b>${res.hostId}</b>님의 대한 후기를 삭제하시겠습니까?
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-danger"
														onclick="javascript:location.href='review_delete?reservationNum=${res.reservationNum}'">삭제하기</button>
													<button type="button" class="btn btn-secondary"
														data-dismiss="modal">취소</button>
												</div>
											</div>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan='2'>${res.reviewContent}<br> <br> <fmt:formatDate
										pattern="yyyy년 MM월 dd일" value="${res.reviewDate}" />
								</td>
							</tr>
						</table>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>