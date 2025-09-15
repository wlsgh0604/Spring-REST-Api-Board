<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <style>
        body {
		    font-family: "맑은 고딕", sans-serif;
		    background-color: #f8f9fa;
		    min-height: 100vh;
		    margin: 0;
		    padding: 20px;
		
		    display: flex;
		    flex-direction: column; /* 세로로 쌓기 */
		    align-items: center; 
        }

        .read-container {
            width: 70%;
            max-width: 800px;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 20px;
        }

        h2 {
            margin-bottom: 15px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 8px;
        }

        .meta {
            font-size: 14px;
            color: #555;
            margin-bottom: 15px;
        }

        .meta span {
            margin-right: 15px;
        }

        .content {
            min-height: 200px;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 20px;
            white-space: pre-line; /* 줄바꿈 유지 */
        }

        .source {
            font-size: 13px;
            color: #666;
            margin-bottom: 20px;
        }

        .btn-area {
            text-align: right;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            margin-left: 8px;
            border-radius: 5px;
            border: none;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-list {
            background: #6c757d;
            color: #fff;
        }

        .btn-list:hover {
            background: #495057;
        }

        .btn-edit {
            background: #007bff;
            color: #fff;
        }

        .btn-edit:hover {
            background: #0056b3;
        }

        .btn-delete {
            background: #dc3545;
            color: #fff;
        }

        .btn-delete:hover {
            background: #a71d2a;
        }
    </style>
</head>
<body>
	<c:if test="${not empty msg}">
	    <script>
	        alert("${msg}");
	    </script>
	</c:if>
    <div class="read-container">
        <h2>${board.subject}</h2>
        <div class="meta">
            <span>작성자: ${board.nickname}</span>
            <span>작성일: ${board.regist_time}</span>
            <span>조회수: ${board.hit}</span>
        </div>
        <div class="content">
            ${board.contents}
        </div>
        <div>
            <span>출처:${board.source}</span>
		</div>
        <div class="btn-area">
            <a href="/board" class="btn btn-list">목록</a>
            <form action="delete" method="post" style="display:inline;">
			    <input type="hidden" name="no" value="${board.no}">
			    <button type="button" class="btn btn-delete" onclick="openModal()">삭제</button>
			</form>
			<form action="update" method="get" style="display:inline;">
			    <input type="hidden" name="no" value="${board.no}">
			    <button type="submit" class="btn btn-edit">수정</button>
			</form>
        </div>
    </div>
    <div class="comment-container" style="margin-top:30px; padding-top:15px;padding-left:30px; padding-right:45px; background:#fff; border:1px solid #ddd; border-radius:8px;">
    <c:forEach var="comment" items="${commentList}">
        <div style="margin-left:${comment.order_no * 20}px; padding:10px; border-bottom:1px solid #eee;">
            <b>${comment.nickname}</b>
            <span style="color:#777; font-size:12px;">(${comment.reg_date})</span>
            <div style="margin-top:5px;">${comment.contents}</div>
            
	        <c:if test="${comment.hidden == 0}">
	            <div style="margin-top:5px;">
	                <form action="reply" method="post" style="display:inline;">
	                    <input type="hidden" name="board_no" value="${board.no}">
	                    <input type="hidden" name="parent" value="${comment.no}">
	                    <input type="hidden" name="groupId" value="${comment.groupId}">
	                    <input type="hidden" name="order_no" value="${comment.order_no}">
						<button type="button" class="btn btn-list" onclick="toggleReplyForm(${comment.no})">답글</button>
	                </form>
	                <form action="replyDelete" method="post" style="display:inline;">
	                    <input type="hidden" name="no" value="${comment.no}">
	                    <input type="hidden" name="board_no" value="${board.no}">
	                    <input type="password" name="password" placeholder="비밀번호" required
	                           style="padding:4px; width:120px; border:1px solid #ccc; border-radius:4px;">
	                    <button type="submit" class="btn btn-delete">삭제</button>
	                </form>
	            </div>
	            <form id="replyForm-${comment.no}" action="reply" method="post" style="display:none; margin-top:10px;">
	                <input type="hidden" name="board_no" value="${board.no}">
	                <input type="hidden" name="parent" value="${comment.no}">
	                <input type="hidden" name="groupId" value="${comment.groupId}">
	                <input type="hidden" name="order_no" value="${comment.order_no}">
	                <div>
	                    <input type="text" name="nickname" placeholder="닉네임" required
	                           style="padding:6px; width:25%; border:1px solid #ccc; border-radius:4px;">
	                    <input type="password" name="password" placeholder="비밀번호" required
	                           style="padding:6px; width:25%; border:1px solid #ccc; border-radius:4px;">
	                </div>
	                <textarea name="contents" placeholder="답글을 입력하세요" required
	                          style="width:100%; height:60px; padding:6px; border:1px solid #ccc; border-radius:4px; resize:none;"></textarea>
	                <div style="text-align:right; margin-top:5px;">
	                    <button type="submit" class="btn btn-edit">등록</button>
	                </div>
				</form>
	        </c:if>
        </div>
    </c:forEach>
    <form action="reply" method="post" style="margin-bottom:20px;">
        <input type="hidden" name="board_no" value="${board.no}">
        <div style="margin-bottom:10px;">
            <input type="text" name="nickname" placeholder="닉네임" required
                   style="padding:8px; width:30%; border:1px solid #ccc; border-radius:4px;">
            <input type="password" name="password" placeholder="비밀번호" required
                   style="padding:8px; width:30%; border:1px solid #ccc; border-radius:4px;">
        </div>
        <textarea name="contents" placeholder="댓글을 입력하세요" required
                  style="width:100%; height:80px; padding:8px; border:1px solid #ccc; border-radius:4px; resize:none;"></textarea>
        <div style="text-align:right; margin-top:10px;">
            <button type="submit" class="btn btn-edit">댓글 등록</button>
        </div>
    </form>
	</div>
</body>

<!-- 모달 -->
<div id="deleteModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; 
    background:rgba(0,0,0,0.5); justify-content:center; align-items:center;">
    <div style="background:#fff; padding:20px; border-radius:8px; width:300px; text-align:center;">
        <h3>비밀번호 확인</h3>
        <form id="deleteForm" action="delete" method="post">
            <input type="hidden" name="no" value="${board.no}">
            <input type="password" name="password" placeholder="비밀번호 입력" required style="width:80%; padding:8px; margin:10px 0;">
            <div>
                <button type="submit" class="btn btn-delete">확인</button>
                <button type="button" class="btn btn-list" onclick="closeModal()">취소</button>
            </div>
        </form>
    </div>
</div>

<script>
	function openModal() {
	    document.getElementById("deleteModal").style.display = "flex";
	}
	function closeModal() {
	    document.getElementById("deleteModal").style.display = "none";
	}
	function toggleReplyForm(commentId) {
	    const form = document.getElementById("replyForm-" + commentId);
	    if (form.style.display === "none" || form.style.display === "") {
	        form.style.display = "block";
	    } else {
	        form.style.display = "none";
	    }
	}
</script>

</html>