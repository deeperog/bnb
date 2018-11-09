<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>방 예약하기</title>
        <link rel="stylesheet" href="resources/css/style-umki.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />

    </head>

    <body>
        <div class="wrapper">
            <input type="text" id="datepicker" placeholder=" 체크인 " readonly="true" />
            <i class="ion-calendar"></i>
        </div>
        <div class="wrapper">
            <input type="text" id="return" placeholder=" 체크아웃 " readonly="true">
            <i class="ion-calendar"></i>
        </div>

        <script>
        
        var inmm = 0;
    	var indd = 0;
    	var outmm = 0;
    	var outdd = 0;
    	var day = 0;
    	var month = 0;
    	var lastDay = 0;
    	var diffDate = 0;
    	
        function temp(){
            $.ajax({
            	async : false,
                url: '${pageContext.request.contextPath}/reservation/possible',
                type: 'GET',
                datatype: 'json',
                /* data : 방번호 */
                success: function(data) {
                    $(data).each(
                        function(key, value) {
                        	inyy = Number(value.checkIn.substring(0, 4));
                        	inmm = Number(value.checkIn.substring(5, 7));
                        	indd = Number(value.checkIn.substring(8, 10));
                        	outyy = Number(value.checkOut.substring(0, 4));
                        	outmm = Number(value.checkOut.substring(5, 7));
                        	outdd = Number(value.checkOut.substring(8, 10));
                        	day = outdd - indd;
                        	month = outmm - inmm;
                        	lastDay = new Date(new Date(2018, inmm-1,1) - 1).getDate();
                        	inDate = new Date(new Date(inyy, inmm-1, indd));
                        	outDate = new Date(new Date(outyy, outmm-1, outdd));
                        	diffDate = (outDate-inDate)/(1000 * 3600 * 24);
                        	
                        	console.log(diffDate);
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
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
                    "7월", "8월", "9월", "10월", "11월", "12월"
                ],
                monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
                    "7월", "8월", "9월", "10월", "11월", "12월"
                ],
                dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
                dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                weekHeader: "주",
                dateFormat: "yy년 mm월 dd일",
                firstDay: 0,
                isRTL: false,
                showMonthAfterYear: true,
                yearSuffix: "년"
            })

            $("#datepicker").datepicker({
                showAnim: 'drop',
                minDate: 0,
                onSelect: function(selected, event) {
                    window.parent.postMessage(selected, "*");
                },

                	
                beforeShowDay: function(date) {
                	var d = date.getDate();
                    var m = date.getMonth();
                    console.log(diffDate);
                    if ((m == inmm || d == indd) && diffDate > 0) {
                    	diffDate--;
                    	indd++;
                    	if(d == lastDay){
                    		indd = 1;
                    		if(m!=12){
                    			inmm++;
                    		}else{
                    			inmm = 1;
                    		}
                    	}
                    	
                        return [false];
                    } else {
                        return [true];
                    }
                   
                    
                },
                onClose: function(selected) {
                    var year = Number(selected.substring(0, 4));
                    var month = Number(selected.substring(6, 8));
                    var date = Number(selected.substring(10, 12));

                    var jj = new Date(year, month - 1, date + 1);

                    $('#return').datepicker("option", "minDate", jj);
                    temp();
                  	            
                },
                
                onChangeMonthYear : function(){
                	if(diffDate==0){
                  	   	
                		temp();
                		console.log("test");
                     }
                }
                
            });


            $("#return").datepicker({
                showAnim: 'drop',
                minDate: 0,
                onSelect: function(selected, event) {

                    window.parent.postMessage(selected, "*");
                }
            });

        </script>
    </body>

    </html>