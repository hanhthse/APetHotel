<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${listCages == null}">
    <c:redirect url="/home"></c:redirect>
</c:if>