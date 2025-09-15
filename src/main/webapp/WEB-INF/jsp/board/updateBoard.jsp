<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글수정</title>
    <script src="https://code.jquery.com/jquery-3.4.1.js"></script>
    <style>
        body {
            font-family: "맑은 고딕", sans-serif;
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
        }

        .form-container {
            width: 70%;
            max-width: 700px;
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

        th {
            text-align: left;
			width: 70px;
			padding: 20px;
			vertical-align: top;
        }

        td {
            padding: 8px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn-area {
            text-align: right;
            margin-top: 15px;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            margin-left: 8px;
            border-radius: 5px;
            border: none;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-submit {
            background: #007bff;
            color: #fff;
        }

        .btn-submit:hover {
            background: #0056b3;
        }

        .btn-cancel {
            background: #6c757d;
            color: #fff;
        }

        .btn-cancel:hover {
            background: #495057;
        }

        #editor {
            width: 100%;
            min-height: 200px;
            border: 1px solid #ccc;
            padding: 8px;
            overflow-y: auto;
        }

        #uploadImageInput {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
	<div class="form-container">
	    <h2>글수정</h2>
	    <form action="updateBoard" method="post" id="frm">
			<input type="hidden" name="no" id="no" value="${board.no}">
	    	<table>
		        <tr>
	                <th>제목</th>
	                <td colspan="3"><input type="text" name="subject" value="${board.subject}" required></td>
	            </tr>
	            <tr>
	                <th>작성자</th>
	                <td>${board.nickname}</td>
	                <th>비밀번호</th>
	                <td><input type="password" name="password" value="${board.password}" required></td>
	            </tr>
	            <tr>
	            	<td colspan=4>
	                <div contenteditable="true" id="editor">${board.contents}</div>
	                <input type="hidden" name="contents" id="contentsHidden">
	            </td>
	            </tr>
	            <tr>
	                <th>출처</th>
	                <td colspan="3"><input type="text" name="source" value="${board.source}"></td>
	            </tr>
	        </table>

        <div class="btn-area">
            <input type="file" id="uploadImageInput" accept="image/*" multiple>
            <button type="button" id="save" class="btn btn-submit">수정</button>
            <button type="button" id="cancel" class="btn btn-cancel">취소</button>
        </div>
    </form>
</div>

<script>
const editor = document.getElementById("editor");
const hiddenInput = document.getElementById("contentsHidden");
const input = document.getElementById("uploadImageInput");

// 이미지 삽입
function insertImage(url){
    editor.focus(); // 포커스 강제
    const img = document.createElement("img");
    img.src = url;
    img.style.maxWidth = "100%";
    img.decoding="async";

    const sel = window.getSelection();
    if(!sel.rangeCount) {
        editor.appendChild(img);
        return;
    }

    const range = sel.getRangeAt(0);
    range.insertNode(img);
    range.setStartAfter(img);
    range.collapse(true);
    sel.removeAllRanges();
    sel.addRange(range);
}

// 파일 업로드
input.addEventListener("change", async () => {
    const files = input.files;
    if(!files.length) return;

    for(let file of files){
        const formData = new FormData();
        formData.append("file", file);

        try {
            const res = await fetch("<%=request.getContextPath()%>/api/uploadImage", { method: "POST", body: formData });
            const data = await res.json();
            if(data.success){
                insertImage(data.url);
            } else {
                alert("업로드 실패: " + data.error);
            }
        } catch(e) {
            alert("업로드 중 에러 발생");
            console.error(e);
        }
    }
});

// 저장 버튼
document.getElementById("save").addEventListener("click", () => {
    hiddenInput.value = editor.innerHTML;
    document.getElementById("frm").submit();
});

// 취소 버튼
document.getElementById("cancel").addEventListener("click", () => {
    window.location.href = "<%=request.getContextPath()%>/";
});
</script>
</body>
</html>
