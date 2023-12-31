<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="<%=request.getContextPath() %>"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재고상세</title>
    <%@ include file="/head.jsp" %>

    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 플러그인 연결-->
    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <!-- datatables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.css">
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.js"></script>

    <!-- 스타일 초기화 -->
    <link rel="stylesheet" href="${path}/css/reset.css">
    <!-- 웹 폰트 -->
    <link rel="stylesheet" href="${path}/css/font.css">

    <!-- css 모듈화 -->
    <link rel="stylesheet" href="${path}/css/common.css">
    <link rel="stylesheet" href="${path}/css/hd.css">
    <link rel="stylesheet" href="${path}/css/ft.css">
    <link rel="stylesheet" href="${path}/css/asidebar.css">
    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; min-height: 200vh; background-color: #fff;
            background-repeat: no-repeat; background-position: center -250px; }
        .contents::after { content:""; clear:both; display:block; width:100%; }

        .page { clear:both; width: 100vw; height: 200vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center;  color:rgb(0,0,0);
            padding-bottom: 1.3em; }

        .breadcrumb { clear:both;
            width:1200px; margin: 0 auto; text-align: right; color:rgb(0,0,0);
            padding-top: 28px; padding-bottom: 28px; }
        .breadcrumb a { color:rgb(0,0,0); }



        /* 테이블 스타일 */
        .tb1 {
            width: 70%;
            margin: 50px auto;
            font-size: 20px;
            border-collapse: collapse;
        }

        .tb1 th {
            background-color: #527AF2;
            color: #fff;
            padding: 16px;
            border: 1px solid #527AF2;

        }

        .tb1 td {
            padding: 12px 16px;
            border: 1px solid #ddd;
            text-align: center;
            line-height: 24px;

        }

        .tb1 th:first-child {
            width: 40px;
        }

        .tb1 tbody {

        }

        .tb1 .item1 {
            width: 10%;
        }

        .tb1 .item2 {
            width: 20%;
        }

        /* 기타 버튼 스타일 */
        .inbtn {
            display: inline-block;
            border-radius: 8px;
            width: 80px;
            text-align: center;
            background-color: #527AF2;
            color: #fff;

            cursor: pointer;
            transition: background-color 0.3s;
            margin: 4px;

        }

        .inbtn:hover {
            background-color: #666666;
        }

        .btn_group {
            margin-top: -38px;
            z-index: 1000;
            position: relative;
        }

        .btn_group p {
            float: right;

        }
    </style>
</head>

<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="/header.jsp" %>
    </header>
    <%@ include file="./adminAside.jsp"%>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="/admin/baordList.jsp">재고상세</a></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">재고상세</h2>


                <table class="tb1" id="myTable">
                    <thead>
                    <tr>


                        <th class="item1" style="text-align: center">번호</th>
                        <%--<th class="item2" style="text-align: center">카테고리</th>--%>
                        <th class="item3" style="text-align: center">상품명</th>
                        <th class="item4" style="text-align: center">재고수량</th>
                        <th class="item6" style="text-align: center">상품가격</th>
                        <th class="item7" style="text-align: center">총판매량</th>
                        <th class="item8" style="text-align: center">총판매수익</th>
                    </tr>
                    </thead>
                    <tbody>


                    <c:forEach var="inv" items="${invList }" varStatus="status">

                        <c:if test="${cus.id ne 'admin'}">
                            <tr>
                                <td class="item1">${status.count}</td>
                                    <%--<td class="item2">${inv.cate}</td>--%>
                                <td class="item3">${inv.pname}</td>
                                <td class="item4">${inv.pamount}</td>
                                <td class="item6">${inv.pprice}</td>
                                <td class="item7">${inv.totalamount}</td>
                                <td class="item8">${inv.totalprice}</td>

                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>

                <a href="${path}/InventoryList.do"class="inbtn delete_btn">뒤로가기</a>
                <%-- <a href="${path}/DeleteCustom.do?id=${cus.id}"class="inbtn delete_btn">탈퇴</a>--%>

                <script>
                    $(document).ready(function () {
                        $('#myTable').DataTable({
                            order: [[1, 'asc']], //0번째 컬럼을 기준으로 내림차순 정렬
                            info: false,
                            dom: 'lt<f>p',
                            language: {
                                emptyTable: '작성된 글이 없습니다.'
                            }

                        });
                    });
                    $(document).ready(function () {
                        $('.dataTables_paginate').css({
                            'textAlign': 'left',
                            'float': 'none',
                            'margin-top': '10px',
                        });
                        $('.dataTables_filter').css({
                            'float': 'left',
                            'margin-top': '14px',
                            'margin-right': '280px'
                        });
                        $('#myTable_paginate').css({
                            'margin-right': '100px'
                        });


                    });

                </script>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="/footer.jsp" %>
    </footer>
</div>
</body>
</html>