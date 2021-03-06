<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="cd" tagdir="/WEB-INF/tags" %>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0" /> -->
    <title>COFFEE</title>
    <link rel="stylesheet" href="<%=cp%>/resource/css/reset.css" />
    <link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" />
    <link rel="stylesheet" href="<%=cp%>/resource/css/members.css" />
    <script src="<%=cp %>/resource/js/jquery-3.5.1.min.js"></script>
    <script>
    $(function(){
    	$("p.controller a.modify").click(function(){
    		$(this).closest("div.detail").find("p.controller").eq(0).css("display","none");
    		$(this).closest("div.detail").find("p.controller").eq(1).css("display","block");
    		return false;
    	});
    });
    </script>
  </head>
  <body>
    <div id="wrap">
      <header id="header">
        <jsp:include page="/WEB-INF/views/layout/header.jsp"/>
      </header>
      <main id="content">
        <div id="main">
          <article id="main_container">
            <!-- Content영역 -->
            <div class="banner_visual">
              <h2><span>쿠앤크 멤버스</span></h2>
              <div class="visual_text">
                <span
                  >쉽고 빠른 주문, 편리한 결제와 적립은 기본<br />친구에게 선물까지, 쿠앤크멤버스를
                  경험해보세요.</span
                >
              </div>
              <jsp:include page="/WEB-INF/views/layout/members_lnb.jsp"/>
            </div>
            <div class="row">
              <div class="row_title">
                <h3><strong class="strong">${sessionScope.member.nickname}</strong>님의 카드 상세정보</h3>
              </div>
              <div class="card_container card_container_full">
                <ul>
                  <li>
                    <figure>
                      <img src="<%=cp %>${cardDTO.thumbnail}" alt="card" />
                    </figure>
                    <div class="detail">
                      <p class="card_title detail controller"> 
                        <strong>${cardDTO.cardName}</strong><a href="#" class="modify">수정</a>
                      </p>
                      <form action="<%=cp%>/members/modifyCardName.do" method="post" name="modifyCardName">
	                      <p class="card_title detail modify controller">
								<input type="hidden" name="cardNum" value="${cardDTO.cardNum}" />
		                      	<input type="text" name="cardName" value="${cardDTO.cardName}" maxlength="10"/><a href="#" class="modify" onclick="javascript:document.modifyCardName.submit();">수정</a>
	                      </p>
	                  </form>
                      <p class="card_id"><cd:card identity="${cardDTO.cardIdentity }"/></p>
                      <p class="card_remain">잔액:&nbsp;<strong><fmt:formatNumber value="${cardDTO.balance}"/></strong>원</p>
                      <ul class="card_control">
                        <li>
                          <a href="<%=cp %>/members/charge.do?cardNum=${cardDTO.cardNum}" class="card_button">충전하기</a>
                        </li>
                        <li><a href="<%=cp %>/members/close.do?cardNum=${cardDTO.cardNum}" class="card_button">해지</a></li>
                      </ul>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
            <div class="row margin_bottom">
                 <ul class="tab detail">
                   <li ${tab=="usage" or empty tab?"class=\"on\"":""}><a href="<%=cp%>/members/detail.do?cardNum=${cardDTO.cardNum}&amp;tab=usage">사용내역</a></li>
                   <li ${tab=="charge"?"class=\"on\"":""}><a href="<%=cp%>/members/detail.do?cardNum=${cardDTO.cardNum}&amp;tab=charge">충전내역</a></li>
                 </ul>
            </div>
            <div class="row">
              <table class="table" id="card_history">
                <c:if test="${tab=='usage' or empty tab}">
                <thead>
                  <tr>
                    <td class="col_no">No</td>
                    <td class="col_category">구분</td>
                    <td class="col_content">주문 내역</td>
                    <td class="col_amount">금액</td>
                    <td class="col_date">날짜</td>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="history" items="${orderHistory}" varStatus="status">
                  <tr>
                    <td class="col_no">${status.count}</td>
                    <td class="col_category">구매</td>
                    <td class="col_content">상품 구매</td>
                    <td class="col_amount"><fmt:formatNumber value="-${history.totalPaymentAmount}"/></td>
                    <td class="col_date">${history.orderDate}</td>
                  </tr>
                </c:forEach>
                </c:if>
                <c:if test="${tab=='charge'}">
                <thead>
                  <tr>
                    <td class="col_no">No</td>
                    <td class="col_category">구분</td>
                    <td class="col_content">내역</td>
                    <td class="col_amount">금액</td>
                    <td class="col_date">날짜</td>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="charge" items="${cardChargeList}" varStatus="status">
                  <tr>
                    <td class="col_no">${status.count}</td>
                    <td class="col_category">충전</td>
                    <td class="col_content">온라인 충전</td>
                    <td class="col_amount"><fmt:formatNumber value="+${charge.chargeAmount}"/></td>
                    <td class="col_date">${charge.chargeDate}</td>
                  </tr>
                </c:forEach>
                </c:if>
                </tbody>
              </table>
            </div>
            <div class="row">
              <a href="<%=cp %>/members/list.do" class="list_button">목록</a>
            </div>
            <!-- Content 영역 끝 -->
          </article>
        </div>
      </main>
      <footer id="footer">
        <jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
      </footer>
    </div>
  </body>
</html>
