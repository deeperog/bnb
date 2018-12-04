<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>


</script>
</head>
<body>
	<%@ include file="/resources/common/includeHead.jsp"%>
	<%@ include file="/resources/common/Navbar.jsp"%>
	
	<c:if test="${regFail ne null}">
		<script>alert("회원가입 실패. 다시 시도해주세요.");</script>
		<c:remove var="regFail" scope="session"/>
	</c:if>

	<div id="userRegForm">
		<!-- Begin page content -->
		<div role="main" class="hyeon-container">
			<div class="row justify-content-md-center">
				<div class="col col-md-5 col-lg-4">
				
				<c:if test="${InvalidBirth ne null}">
						<div id="dateAlert" style="color:red;">생년월일을 정확하게 입력해주세요.</div> <br>
							<script>
								$(document).ready(function(){
									$('#dateAlert').fadeOut(5000);
								});
							</script>
						<c:remove var="InvalidBirth" scope="session"/>
					</c:if>
				
				<div class="hyeon-title"><h2>회원가입</h2></div>
				
					<form method="post" id="gRegForm" enctype="multipart/form-data">
					
						<input type="email" id="inputUserId" name="userId" class="form-control hyeon-reg-input" value="${gMail}" readonly />
						<input type="hidden" id="userPw-1" name="userPw" class="form-control hyeon-reg-input" value="" />
						<input type="text" id="inputUserName" name="userName" class="form-control hyeon-reg-input" value="${gName}" placeholder="이름" />
						<input type="text" id="inputNickName" name="nickName" class="form-control hyeon-reg-input" placeholder="닉네임" />
						<div id="alertNickName" class="regAlert" style="display:none; color: #dc3545;"></div>
						<label class="form-check-label mt-2 mb-2" style="margin-bottom: 3px; font-weight: bold;">사진 </label>
						<input type="file" name="photoFile" class="form-control hyeon-reg-input" />
						<input type="hidden" name="host" value=0 style="display:none" />
						<input type="hidden" name="admin" value=0 style="display:none" />
						<!-- <input type="hidden" name="userKey" value="asd123" style="display:none" /> -->
						<input type="hidden" name="userCheck" value=1 style="display:none" />
						<input type="hidden" name="point" value=0 style="display:none" />
						<input type="hidden" name="disabled" value=1 style="display:none" />
						
						<div>
						<label class="form-check-label mt-2 mb-2" style="margin-bottom: 3px; font-weight: bold;">생일</label>
						<p>회원 가입을 하시려면 만 18세 이상이어야 합니다.<br>
						생일은 다른 회원에게는 공개되지 않습니다.</p>
						</div>
						<div>
						<select name="month" class="hyeon-form-control hyeon-left">
					 		<option value="">월</option>
								<c:forEach begin="1" end="12" var="month" >
									<option>${month}</option>
								</c:forEach>
						</select>
						
						<select name="day" class="hyeon-form-control">
					 		<option value="">일</option>
								<c:forEach begin="1" end="31" var="day" >
									<option>${day}</option>
								</c:forEach>
						</select>
						
						<select id="select-year" name="year" class="hyeon-form-control hyeon-right">
					    	<option value="">년도</option>

      						    <c:set var="today" value="<%=new java.util.Date()%>" />

          						<fmt:formatDate value="${today}" pattern="yyyy" var="nowYear"/> 

         						<c:forEach begin="0" end="120" var="i">

           							<option><c:out value="${nowYear - i}" /></option>

          						</c:forEach>

						</select>
						</div>
						<div> 
							<textarea name="userInfo" class="form-control hyeon-reg-input" cols="30" placeholder="자기소개"></textarea>
						</div>
						<input id="gRegBtn" class="btn btn-lg btn-danger btn-block" type="button" style="margin-bottom: 20px" value="회원가입" />
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<script>
		// 아이디 입력란에 포커스 주기
		$(document).ready(function(){
			$('#inputUserId').focus();
			
		});
		
		// 비밀번호 유효성 검사
		$('#userPw-1').blur(function checkPassword(){
				$('#alertPw').empty();
				$('#alertPw').css("display","none");
				$('#fail-pw-1').val('fail');
				
			var checkNumber = $('#userPw-1').val().search(/[0-9]/g);
			var checkEnglish = $('#userPw-1').val().search(/[a-z]/ig);

			if(!/^[a-zA-Z0-9]{8,15}$/.test($('#userPw-1').val())){
				$('#alertPw').css("display","");
				$('#alertPw').append("숫자와 영문자 조합으로 8~15자리를 사용해야 합니다.");
			} else if (checkNumber <0 || checkEnglish <0){
				$('#alertPw').css("display","");
				$('#alertPw').append("숫자와 영문자를 혼용하여야 합니다.");
			} else if (/(\w)\1\1\1/.test($('#userPw-1').val())){
				$('#alertPw').css("display","");
				$('#alertPw').append("같은 문자를 4번 이상 연속하여 사용하실 수 없습니다.");
			} else if ($('#inputUserId').val() != '' && $('#inputUserId').val() != null){
				if($('#userPw-1').val().search($('#inputUserId').val()) > -1){
					$('#alertPw').css("display","");
					$('#alertPw').append("비밀번호에 아이디가 포함되었습니다.");
				}else{
					$('#fail-pw-1').val('ok');
					/* alert($('#fail-pw-1').val()); */
				}
			} else {
				$('#fail-pw-1').val('ok');
				/* alert($('#fail-pw-1').val()); */
			}
			/* 이 무접점하고는 느낌이 조금 다른데 이 느낌이 더 좋은거 같네..?? */
		});

		/* $('#userPw-1').blur(function(){
			if(!checkPassword($('#inputUserId').val(), $('#userPw-2').val())){
				$('#alertPw').text('fail');
			} else {
				$('#fail-pw').text('');
				$('#fail-pw').val('');
			}
		}); */

		 // 비밀번호 두개가 일치하는지 검사
		 $('#userPw-2').blur(function(){
			if($('#userPw-1').val() != $('#userPw-2').val()){
				$('#chkPw').empty();
				$('#chkPw').css("display","");
				$('#chkPw').append("비밀번호를 다시 한 번 확인해주세요");
				$('#fail-pw-2').val('fail');
			} else {
				$('#chkPw').empty();
				$('#chkPw').css("display","none");
				$('#fail-pw-2').val('ok');
			}
		});
		
		// 이름 입력했는지 검사
		$('#inputUserName').blur(function(){
			if($('#inputUserName').val() == null ||$('#inputUserName').val() == ''){
				$('#chkName').empty();
				$('#chkName').css("display","");
				$('#chkName').append("이름을 입력해주세요");
			} else {
				$('#chkName').empty();
				$('#chkName').css("display","none");
			}
		});
		
		// 아이디가 비밀번호와 겹치거나 아이디가 중복인지 확인
		$('#inputUserId').blur(function(){
			var userId = $('#inputUserId').val();
			
			if(userId != null && userId != ''){
				if($('#userPw-1').val().search($('#inputUserId').val()) > -1){
					$('#alertPw').css("display","");
					$('#alertPw').empty();
					$('#alertPw').append("비밀번호에 아이디가 포함되었습니다.");
					return false;
				}
			}
			
			if(userId != '' && userId != null){
				$.ajax({
				type: "GET",
				url: "${pageContext.request.contextPath}/userIdChk",
				data: {"userId" : userId},
				success: function(data){
					if(data == "n"){
						$('#alertId').empty();
						$('#alertId').css("display","");
						$('#alertId').append("중복된 아이디입니다.");
					}else{
						$('#alertId').empty();
						$('#alertId').css("display","none");
					}
				}
			});
		}
	});

		// 닉네임 중복체크
		$('#inputNickName').blur(function(){
			var nName = $('#inputNickName').val();
			
			if(nName != '' && nName != null){
				$.ajax({
				type: "GET",
				url: "${pageContext.request.contextPath}/user/nickNameChk",
				data: {"nickName" : nName},
				success: function(data){
					if(data == "n") {
						$('#alertNickName').empty();
						$('#alertNickName').css("display","");
						$('#alertNickName').append("이미 사용중인 닉네임입니다");
					} else if(data == "y"){
						$('#alertNickName').empty();
						$('#alertNickName').css("display","none");
					}
				}
			});
		}
	});
		
	
		 $(function() {
	            $("#gRegBtn").click(function() {
	               
	                console.log('gg');
	                 
	                var nName = $('#inputNickName').val();
	                var nNameChk = '';
	                
	                $.ajax({
	    				type: "GET",
	    				url: "${pageContext.request.contextPath}/user/nickNameChk",
	    				data: {"nickName" : nName},
	    				success: function(data){
	    					if(data == "n") {
	    						nNameChk = "n";
	    					} else if(data == "y"){
	    						nNameChk = "y";
	    					}
	    				}
	                });
	                
	                var pattern = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
	                var year = $('#select-year').val();
	                var month = $('#select-month').val();
	                var day = $('#select-day').val();
	                if(month<10){
	                	month = '0'+month;
	                }
	                if(day<10){
	                	day = '0'+day;
	                }
	                
	                var birth = $('#select-year').val()+'-'+month+'-'+day;
	                var lastDay = new Date(new Date(year, month, 0)).getDate();
	                
	                var today = new Date();
	                var tYear = today.getFullYear();
	                var tMonth = today.getMonth()+1;
	                var tDay = today.getDate();

	                if(tMonth<10){
	                	tMonth = ''+tMonth;
	                }
	                if(tDay<10){
	                	tDay = ''+tDay;
	                }
	                
	                var age = tYear-year;
	                if((month*100 + day) > tMonth*100 + tDay){
	                	age--;
	                }
	                
	            	if(pattern.test(birth) && day<=lastDay && age>18 && nName!='' && nName!=null){
	                    $('#gRegForm').submit();
	                    $('#gRegBtn').val('가입처리중...');
	            	}else if(nName==''||nName==null){
	            		alert('닉네임을 입력해주세요.');	
	            	}else if(day>lastDay){ 
	            		alert('유효하지 않은 생년월일입니다.');
	            	}else if(age<18){ 
	            		console.log('만나이: ' + age);
	            		alert('만 18세 이상만 가입 가능합니다');
	            	}else{ 
	            		console.log('생년월일 : ' + birth);
	            		alert('생년월일을 확인해주세요');
	            	}
	            	
	             });
	        });
		
		
	</script>
	

</body>
</html>