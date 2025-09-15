<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        body {
            font-family: "맑은 고딕", sans-serif;
            background-color: #f8f9fa;
			height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .board-container {
            width: 80%;
            max-width: 900px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f1f3f5;
        }

        th, td {
            border: 1px solid #dee2e6;
            padding: 10px;
            text-align: center;
        }

        th {
            font-weight: bold;
        }

        tr:hover {
            background: #f8f9fa;
        }

        .write-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 8px 16px;
            background: #007bff;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            float: right;
        }

        .write-btn:hover {
            background: #0056b3;
        }
        
        .title-link {
		    display: block;          /* 한 줄 전체를 클릭 가능하게 */
		    padding: 8px;            /* 여백 */
		    text-decoration: none;   /* 밑줄 제거 */
		    color: inherit;          /* 기존 글자 색상 유지 */
		}
		
		.title-link:hover {
		    background-color: #f0f0f0; /* 호버 시 배경 강조 (선택) */
		}
		
		/* 페이지네이션 & 검색 컨테이너 */
	    .bottom-container {
	        margin-top: 20px;
	        text-align: center;
	    }
	
	    /* 페이지네이션 */
	    .pagination {
	        display: inline-block;
	        margin-bottom: 15px;
	    }
	
	    .pagination a, .pagination span {
	        display: inline-block;
	        padding: 6px 12px;
	        margin: 0 3px;
	        border: 1px solid #ddd;
	        border-radius: 4px;
	        color: #007bff;
	        text-decoration: none;
	    }
	
	    .pagination a:hover {
	        background-color: #f0f0f0;
	    }
	
	    .pagination span b {
	        color: #fff;
	        background: #007bff;
	        border-radius: 4px;
	        padding: 6px 12px;
	        display: inline-block;
	    }
	
	    /* 검색폼 */
	    .search-form {
	        /* display: inline-block; */
	        margin-top: 10px;
	    }
	
	    .search-form select, 
	    .search-form input[type="text"], 
	    .search-form button {
	        padding: 6px 10px;
	        margin: 0 3px;
	        border: 1px solid #ddd;
	        border-radius: 4px;
	    }
	
	    .search-form button {
	        background: #007bff;
	        color: white;
	        cursor: pointer;
	    }
	
	    .search-form button:hover {
	        background: #0056b3;
	    }
    </style>
</head>
<body>
	<c:if test="${not empty msg}">
	    <script>
	        alert("${msg}");
	    </script>
	</c:if>
	<div class="board-container">
        <h2>게시판</h2>
        <table>
            <thead>
                <tr>
                    <th>글번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성시간</th>
                </tr>
            </thead>
            <tbody>
			    <c:forEach var="board" items="${list}">
			        <tr>
			            <td>${board.no}</td>
			            <td>
			                <a href="read?no=${board.no}" class="title-link">
			                    <span>${board.subject}</span>
			                </a>
			            </td>
			            <td>${board.nickname}</td>
			            <td>${board.hit}</td>
			            <td>${board.regist_time}</td>
			        </tr>
			    </c:forEach>
            </tbody>
        </table>

        <a href="write" class="write-btn">✍ 글쓰기</a>
        
        <div class="bottom-container">
		    <!-- 페이지네이션 -->
		    <div class="pagination">
		        <c:if test="${startPage > 1}">
		            <a href="?page=${startPage - 1}&searchType=${searchDTO.searchType}&keyword=${searchDTO.keyword}">이전</a>
		        </c:if>
		
		        <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
				    <a href="?page=${pageNum}" 
				       class="${params.page == pageNum ? 'active' : ''}">
				       ${pageNum}
				    </a>
				</c:forEach>
		
		        <c:if test="${endPage < totalPage}">
		            <a href="?page=${endPage + 1}&searchType=${searchDTO.searchType}&keyword=${searchDTO.keyword}">다음</a>
		        </c:if>
		    </div>
		
		    <!-- 검색 -->
		    <div class="search-form">
		        <form method="get" action="/board">
		            <select name="searchType">
		                <option value="subject" ${searchDTO.searchType == 'subject' ? 'selected' : ''}>제목</option>
		                <option value="contents" ${searchDTO.searchType == 'contents' ? 'selected' : ''}>내용</option>
		                <option value="nickname" ${searchDTO.searchType == 'nickname' ? 'selected' : ''}>작성자</option>
		            </select>
		            <input type="text" name="keyword" value="${searchDTO.keyword}" placeholder="검색어 입력">
		            <button type="submit">검색</button>
		        </form>
		    </div>
		</div>
    </div>
    
	
</body>
</html>