<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
$(document).ready(function(){
    //체크박스 전체 선탣&해제
    $('#ck_all').click(function(){
         if($("#ck_all").prop("checked")){
            $("input[type=checkbox]").prop("checked",true); 
        }else{
            $("input[type=checkbox]").prop("checked",false); 
        }
    });
 
    $('#delete').click(function(){
        if(confirm("삭제하시겠습니까?")){
            $("input[name=checkRow]:checked").each(function(){
                var tr_value =$(this).val();
                var tr=$("tr[data-tr_value='"+tr_value+"']");
                tr.remove();
            });
        }else{
            return false;
        }
    });
 
});
</script>
</head>
<body>
<table>
        <tr>
            <th class="checkbox">
                <input type="checkbox" id="ck_all">
            </th>
        </tr>
        <tr data-tr_value="1">
            <td><input type="checkbox" name="checkRow" value="1"></td>
        </tr>
         <tr data-tr_value="2">
            <td><input type="checkbox" name="checkRow" value="2"></td>
        </tr>
         <tr data-tr_value="3">
            <td><input type="checkbox" name="checkRow" value="3"></td>
        </tr>
        <tr data-tr_value="4">
            <td><input type="checkbox" name="checkRow" value="4"></td>
        </tr>
</table>
 
<input type="button" id="delete">
</body>
</html>