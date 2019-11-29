<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>
	<table summary="Test" cellpadding="0" cellspacing="0" id="testTbl">
		<caption>Test</caption>
		<colgroup>
			<col width="10%" />
			<col width="30%" />
			<col width="30%" />
			<col width="30%" />
		</colgroup>
		<thead>
			<th scope="col"><input type="checkbox"
				onClick="fn_allChecked();" /></th>
			<th scope="col">성명</th>
			<th scope="col">나이</th>
			<th scope="col">성별</th>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${!empty list}">
					<c:forEach var="dto" items="${list}"
						varStatus="index">
						<tr>
							<td></td>
							<td>${dto.prod_name}</td>
							<td>${dto.price}</td>
							<td>${dto.seq}</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="4">검색결과가 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<div>
		<a href="#" onClick="fn_btnChoice()">선택</a>
	</div>
	<div>
		<a href="#" onClick="fn_delRow('chkObject');">삭제</a>
	</div>
	<script>

		function fn_delRow(chkObjNm) { //체크데이터 row 삭제하기
			if ($("input[name=" + chkObjNm + "]").is(":checked")) {
				if (confirm("삭제 하시겠습니까?")) {
					for (var i = $("[name='" + chkObjNm + "']:checked").length - 1; i > -1; i--) {
						$("[name='" + chkObjNm + "']:checked").eq(i).closest(
								"tr").remove();
					}
				}
			} else {
				alert("선택된 데이터가 없습니다.");
			}
		}
		
		//row 추가
		function fn_addRow(addData, chkCnt) {
			if (Number(chkCnt) > 0) {
				var tblObj = $("#testTbl > tbody:last");
				for (var k = 0; k < Number(chkCnt); k++) {
					var orw = $("<tr></tr>");
					var rChk = $("<td><input type='checkbox' name='chkObject' value='"+addData[k].dbKey+"'></td>");
					var rName = $("<td></td>").text(addData[k].name);
					var rAge = $("<td></td>").text(addData[k].age);
					var rGender = $("<td></td>").text(addData[k].gender);
					tblObj.append(row);
					row.append(rChk);
					row.append(rName);
					row.append(rAge);
					row.append(rGender);
				}
			}
		}
	</script>
</body>
</html>