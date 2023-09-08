<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="patient.*"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	PatientresDAO pdao = new PatientresDAO();
	int nulllistCnt = 0;
	int nulllistPages = 0;
	nulllistCnt = pdao.comlistresCnt(m_id);
	if(nulllistCnt%5 == 0) {
		nulllistPages = nulllistCnt/5;
	} else {
		nulllistPages = nulllistCnt/5 + 1;
	}
%>
	<div id='restable'>
		<form name="resinfo">
			<table>
				<thead>
					<tr>
						<td>예약코드</td>
						<td>이름</td>
						<td>피간병인<br>상세정보</td>
						<td>간병장소</td>
						<td>주소</td>
						<td>간병일시</td>
						<td>매칭서비스<br>정보</td>
						<td>간병인</td>
						<td>비고</td>
					</tr>
				</thead>
				<%

				m_id = (String)session.getAttribute("m_id");
				List<PatientresVO> nulllist = pdao.listnull(m_id, (nPage-1)*5);
				
				Set<String> processedResCodes = new HashSet<>();
				List<PatientresVO> uniqueList = new ArrayList<>();
				
				for(PatientresVO nList : nulllist) {
					
					String res_code = nList.getRes_code();
		            if (!processedResCodes.contains(res_code)) {
		                processedResCodes.add(res_code);
		                uniqueList.add(nList);
		            }
					String t_name = nList.getCaretaker();
					Date start_date = nList.getStartdate();
					Date end_date = nList.getEnddate();
					Time start_time = nList.getStarttime();
					Time end_time = nList.getEndtime();
					String caretaker_code = nList.getCaretaker_code();
					String location = nList.getLocation();
					String addr = nList.getAddr();
					String detail_addr = nList.getDetail_addr();
					
					 if (location == null || addr==null || start_date==null) {
			%>

			<tr>
				<td><%=res_code%></td> <td><%=t_name%></td> 
				<td><button onclick="openDetailPopup('<%=res_code %>')">더보기</button></td>
				<td> <% if(location==null) { %>
    					<a href="../reservation/location?res_code=<%=res_code%>">미작성</a>
    					<% } else if(location!=null) { 
    							if(location.equals("home")) { %>
    							자택 <% }else { %>
    						<%=location %>
    						<% }} %>
				</td>
				
				<td> <% if(addr==null) { %>
    					<a href="../reservation/location?res_code=<%=res_code%>">미작성</a>
    				<% } else if(addr!=null) { %>
    					<%=addr %> <% if(detail_addr!=null) { %> <%=detail_addr %> <% }} %>
				</td>
				<td><% if(start_date==null) { %>
    					<a href="../reservation/date?res_code=<%=res_code%>">미작성</a>
					<% } else if(start_date!=null) { %>
						일시 : <%=start_date%> ~ <br> <%=end_date %><br>시간 : <%=start_time%> ~ <%=end_time%>
					<% } %>
				</td>
				
				<td>
					<%
					List<TpreferenceVO> preList2 = pdao.listtpre(res_code);
					for(TpreferenceVO pre : preList2) {
					String pre_age_1 = pre.getPre_age_1();
					
					if(pre_age_1==null){%>
						<a href="../reservation/match?res_code=<%=res_code%>">미작성</a>
					<% } else { %> 
						<button onclick="openmatPopup('<%=res_code %>')">더보기</button> 
					<% }}%>
				</td>
					
				<td>
				미작성
				</td>
				
				<td><a href="../reservation/resdelete.jsp?res_code=<%=res_code%>&caretaker_code=<%=caretaker_code%>"
					onclick="return delok();">취소</a></td>
			</tr>

			<%
			}}
			%>
				
				
		</table>
	</form>
	<div>
		<ul class="pagination pagination-lg">
			<%
				for(int i = 1; i <= nulllistPages; i++) {
			%>
				<li class="page-item" onclick="nulllistPage(<%= i %>);">
					<%= i %>
				</li>
			<%		
				}
			%>
		</ul>
	</div>
</div>

<script>
	function nulllistPage(page) {
		var path = "${context}/member/main?nulllistPage=" + page + "#resNullInfo-tab";
		location.href = path;
	}
</script>