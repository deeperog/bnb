<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>방 예약하기</title>
<link rel="stylesheet" href="resources/css/style-umki.css">
<!-- 결제 시작 -->
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>  -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- 결제 끝 -->
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>

<link rel="stylesheet"
	href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>

<body class="umkibody">
	<form method="post" id="fr">
		<div class="wrapperr">
			<input name="checkIn" type="text" id="datepicker" placeholder=" 체크인 "
				readonly="true" /> <i class="ion-calendar"></i>
		</div>
		<div class="wrapperr">
			<input name="checkOut" type="text" id="return" placeholder=" 체크아웃 "
				readonly="true"> <i class="ion-calendar"></i>
		</div>
		<div class="wrapperr">

			<div id="umki_people" data-toggle="modal"
				data-target="#my80sizeCenterModal">게스트 1명</div>

			<div id="price">가격</div>

			<!-- 80%size Modal at Center -->
			<div class="modal modal-center fade" id="my80sizeCenterModal"
				tabindex="-1" role="dialog"
				aria-labelledby="my80sizeCenterModalLabel">
				<div class="modal-dialog modal-80size modal-center" role="document">
					<div class="modal-content modal-80size">
						<div class="modal-header">
							<h4 class="modal-title" id="myModalLabel">Modal 제목</h4>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>

						<div class="modal-body">
							<div class="umki-people">성인</div>
							<div class="umki-number">
								<div onclick="minusAdult(this)" class="umki-pd umki-rad-m">-</div>
								<div class="umki-pd">1</div>
								<div onclick="plusAdult(this)" class="umki-pd umki-rad-p">+</div>
							</div>
						</div>
						<div class="modal-body">
							<div class="umki-people">어린이</div>
							<div class="umki-number">
								<div onclick="minusChild(this)" class="umki-pd umki-rad-m">-</div>
								<div class="umki-pd">0</div>
								<div onclick="plusChild(this)" class="umki-pd umki-rad-p">+</div>
							</div>
						</div>
						<div class="modal-body">
							<div class="umki-people">유아</div>
							<div class="umki-number">
								<div onclick="minusLittle(this)" class="umki-pd umki-rad-m">-</div>
								<div class="umki-pd-little">0</div>
								<div onclick="plusLittle(this)" class="umki-pd umki-rad-p">+</div>
							</div>
						</div>
						<div class="modal-footer">
							<button onclick="peoplee()" type="button" class="btn btn-default"
								data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		

		<input type="hidden" value="${loginUser.userId}" name="hostId"
			id="umki-hostId" /> <input type="hidden" value="${loginUser.userId}"
			name="userId" /> <input type="hidden"
			value="${selectedRoom.roomsId}" name="roomsId" /> <input
			type="hidden" value="${selectedRoom.price_weekdays}" name="price" />
		<input type="hidden" value="1" name="people" id="people" />

		
	<!-- <button onclick="reservationDo()">예약하기</button> -->  
	<div style="cursor: pointer;" onclick = "reservationDo()">예약하기</div>
</div>  
		<!-- <input type="submit" value="예약하기"/> -->
	</form>

	<script>
            var impossible = new Array();
            var re;
            var now = new Date();
            var day = 0;
            var adult = 1;
            var child = 0;
            var little = 0;
            var limit = ${selectedRoom.avail_adults+selectedRoom.avail_children};
            var checkIn1 = new Date(1899,11,30);
            var checkIn2 = 0;
            var checkOut1 = new Date(1899,11,30);
            var count = 0;
            var pri = 0;
            var IMP = window.IMP; // 생략가능
            
            IMP.init('imp32076790'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
            
            function plusAdult(obj){
            	if(limit > adult+child){
            		$(obj).prev().text(++adult);
            	}
            }
            function plusChild(obj){
            	if(limit > adult+child){
            		$(obj).prev().text(++child);
            	}
            }  
            function plusLittle(obj){
            	if(5 > little){
            		$(obj).prev().text(++little);
            	}
            }
            
            function minusAdult(obj){
            	if(1 < $(obj).next().text()){
            		$(obj).next().text(--adult);
            	}
            }
            function minusChild(obj){
            	if(0 < $(obj).next().text()){
            		$(obj).next().text(--child);
            	}
            }
            function minusLittle(obj){
            	if(0 < $(obj).next().text()){
            		$(obj).next().text(--little);  
            	}
            }
            function peoplee(){
            	var peopleNum = adult+child;
            	$("#umki_people").text("게스트 "+peopleNum+"명");
            	
            	if(little >= 1){
            		$("#umki_people").text("게스트 "+peopleNum+"명, 유아 "+little+"명");
            	}
            	  
            	$('#people').val(peopleNum);
            }

            function temp() {
                $.ajax({
                    async: false,
                    url: '${pageContext.request.contextPath}/reservation/possible',
                    type: 'GET',
                    datatype: 'json',
                    data: {
                        "roomsId": "${selectedRoom.roomsId}"
                    },
                    success: function(data) {
                        $(data).each(
                            function(key, value) {
                                day = value.day;
                                
                                inyy = Number(value.checkIn.substring(
                                    0, 4));
                                inmm = Number(value.checkIn.substring(
                                    5, 7));
                                indd = Number(value.checkIn.substring(
                                    8, 10));
                                
                                if (inmm != 12) {
                                    for (i = 0; i < day; i++) {
                                        impossible.push(new Date(inyy,
                                            inmm - 1, indd + i));
                                    }
                                } else if (inmm == 12) {
                                    for (i = 0; i < day; i++) {
                                        impossible.push(new Date(
                                            inyy + 1, 0 - 1, indd +
                                            i));   
                                    }
                                }
                            });
                    }
                });
            }

            temp();

            $(function() {
                $("#datepicker").datepicker();

            });

            $.datepicker.setDefaults({
                closeText: "닫기",
                prevText: "이전달",
                nextText: "다음달",
                currentText: "오늘",
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
                    "9월", "10월", "11월", "12월"
                ],
                monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
                    "9월", "10월", "11월", "12월"
                ],
                dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
                dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                weekHeader: "주",
                dateFormat: "yy-mm-dd",       
                firstDay: 0,
                isRTL: false,
                showMonthAfterYear: true,
                yearSuffix: "년"
            })

            $("#datepicker")   
                .datepicker({
                    showAnim: 'drop',
                    minDate: 0,
                    onSelect: function(selected, event) {
                        window.parent.postMessage(selected, "*");
                    },
                    beforeShowDay: function(date) {
                    	if(impossible.length > 0 ){
                        $(impossible)
                            .each(
                                function(key, value) {

                                    if (String(date) == String(value)  &&  
                                        (value.getFullYear() == now.getFullYear() &&
                                        value.getMonth() >= now.getMonth()))  {
                                    	
                                    	if(value.getMonth() == now.getMonth() && value.getDate() >= now.getDate()){
                                    		re = [false, "not", ""];
                                            return false;	
                                    	} else if (value.getMonth() > now.getMonth()){
                                    		re = [false, "not", ""];
                                            return false;   
                                    	}
                                        
                                    }  else if (value
                                        .getFullYear() > now
                                        .getFullYear() &&
                                        String(date) == String(value)) {
                                        re = [false, "not", ""];
                                        return false;
                                    }  else {
                                        re = [true];
                                        return true;
                                    }
                                });
                           
                          
                        return re;
                    	}
                        else{
                        	return [true];     
                        }
                    },
                    onClose: function(selected) {
                    	var year = Number(selected.substring(0, 4));
                        var month = Number(selected.substring(5, 7));
                        var date = Number(selected.substring(8, 10));
                        
                        checkIn1 = new Date(year, month - 1, date);
                        checkIn2 = new Date(year, month - 1,
                            date + 1);
                        
                        if (selected != "") {
                            $
                                .ajax({
                                    async: false,
                                    url: '${pageContext.request.contextPath}/reservation/possibleDuration',
                                    type: 'GET',
                                    data: {   
                                        "checkIn": checkIn1,
                                        "now": now,   
                                        "roomsId": "${selectedRoom.roomsId}"
                                    },
                                    datatype: 'json',
                                    success: function(data) {
                                        $(data).each(
                                                function(  
                                                    key,
                                                    value) {
                                                    $('#return').datepicker(
                                                        "option", "maxDate", "+" + value + "d");
                                                });
                                    }
                                });

                            $('#return').datepicker("option",
                                "minDate", checkIn2);
                        }
                        temp(); 
                        
                        if($('#return').val() != ""){  
                        	checkOut1 = new Date($('#return').val().substring(0,4), $('#return').val().substring(5,7)-1, $('#return').val().substring(8,10));
                        }
                        weekend();
                        viewPrice();
                        
                    },

                    onChangeMonthYear: function() {
                        impossible = [];
                        temp();
                    }

                });

            $("#return").datepicker({
                showAnim: 'drop',
                minDate: new Date(),
                onSelect: function(selected, event) {

                    window.parent.postMessage(selected, "*");
                },
            	onClose: function(selected) {
                	var year = Number(selected.substring(0, 4));
                    var month = Number(selected.substring(5, 7));
                    var date = Number(selected.substring(8, 10));
                    var day = selected.substring(12, 13); 
                    
                    checkOut1 = new Date(year, month-1, date);
                    weekend();
                    viewPrice();
                    
            	}
            });
            
            function weekend(){
            	if(checkIn1.getFullYear()>=now.getFullYear() && checkOut1.getFullYear()>=now.getFullYear() ){
                	count = 0;
                	var temp_date = new Date(checkIn1);
                	
                	
                	while(true) {
                	    if(temp_date.getTime() > checkOut1.getTime()-1) {
                	        console.log("count : " + count);
                	        break;
                	    } else {
                	        var tmp = temp_date.getDay();
                	        if(tmp == 5 || tmp == 6) {
                	            count++;             
                	        }  
                	        temp_date.setDate(temp_date.getDate() + 1);
                	    }
                	}
                }
            }
            
            function viewPrice(){   
            	$.ajax({
                    async: false,
                    url: '${pageContext.request.contextPath}/reservation/price',
                    type: 'GET',
                    data: {
                        "checkIn": checkIn1,
                        "checkOut": checkOut1,
                        "cnt" : count,
                        "roomsId": "${selectedRoom.roomsId}"
                    },
                    datatype: 'json',
                    success: function(data) {
                    	console.log("체크인 : " +checkIn1);
                    	console.log("체크아웃 : " +checkOut1);
                    	console.log("돈 : " +data);                    	
                    	if(checkIn1.getFullYear()>=now.getFullYear() && checkOut1.getFullYear()>=now.getFullYear() ){   
                    		$("#price").text(data +"원 입니다.");
                        	pri = data;
                    	}
                    }
                });
            }  
            
/*             $("#fr").submit(function(){
            	if(!$("#datepicker").val()) {
            	    alert("체크인체크해");
            	    return false;
            	  }
            	if(!$("#return").val()) {
            	    alert("체크아웃체크해");
            	    return false;
            	  }
            	if(!$("#umki-hostId").val()) {
            	    alert("로그인해");
            	    return false;
            	  }
            	 
            	IMP.request_pay({
                    pg : 'inicis', // version 1.1.0부터 지원.
                    pay_method : 'card',
                    merchant_uid : 'merchant_' + new Date().getTime(),
                    name : '주문명:결제테스트',
                    amount : '100',
                    buyer_email : 'iamport@siot.do',
                    buyer_name : '구매자이름',
                    buyer_tel : '010-1234-5678',
                    buyer_addr : '서울특별시 강남구 삼성동',
                    buyer_postcode : '123-456',
                   	m_redirect_url : "${pageContext.request.contextPath}/reservation"
                }, function(rsp) {
                    if ( rsp.success ) {
                        var msg = '결제가 완료되었습니다.';
                        msg += '고유ID : ' + rsp.imp_uid;
                        msg += '상점 거래ID : ' + rsp.merchant_uid;
                        msg += '결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        return true;
                    } else {
                        var msg = '결제에 실패하였습니다.';
                        msg += '에러내용 : ' + rsp.error_msg;
                    }
                    alert(msg);  
               	  
                });
           return false;
            });     */
             
            
            function reservationDo(){
            	if(!$("#datepicker").val()) {
            	    alert("체크인체크해");
            	  }else
            	if(!$("#return").val()) {
            	    alert("체크아웃체크해");
            	  }else   
            	if(!$("#umki-hostId").val()) {
            	    alert("로그인해");
            	  }
            	else{  
            	IMP.request_pay({
                    pg : 'inicis', // version 1.1.0부터 지원.
                    pay_method : 'card',
                    merchant_uid : 'merchant_' + new Date().getTime(),
                    name : '주문명:결제테스트',
                    amount : pri,                        
                    buyer_email : 'iamport@siot.do',
                    buyer_name : '구매자이름',
                    buyer_tel : '010-1234-5678',
                    buyer_addr : '서울특별시 강남구 삼성동',
                    buyer_postcode : '123-456',                      	
                }, function(rsp) {  
                    if ( rsp.success ) {
                        var msg = '결제가 완료되었습니다.';
                        msg += '고유ID : ' + rsp.imp_uid;
                        msg += '상점 거래ID : ' + rsp.merchant_uid;
                        msg += '결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        $('#fr').submit();   
                    } else {
                        var msg = '결제에 실패하였습니다.';
                        msg += '에러내용 : ' + rsp.error_msg;
                        
                    }
                    alert(msg);  
               	  
                });
            }
            }
           
 
        </script>
</body>

</html>
