<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="patient.*"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.sql.Time"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

	<div id='restable'>
		<form name="resinfo">
			<table>
				<thead>
					<tr>
						<td>예약코드</td>
						<td>이름</td>
						<td>상세정보</td>
						<td>간병장소</td>
						<td>주소</td>
						<td>간병일시/시간</td>
						<td>매칭서비스<br>정보</td>
						<td>간병인</td>
						<td>비고</td>
					</tr>
				</thead>
				<%
			m_id = (String)session.getAttribute("m_id");
			PatientresDAO dao3 = new PatientresDAO();
			List<PatientresVO> reslist3 = dao3.listres(m_id);
			for (int i = 0; i < reslist3.size(); i++) {
				PatientresVO listvo = (PatientresVO) reslist3.get(i);

				String t_name = listvo.getCaretaker();
				Date start_date = listvo.getStartdate();
				Date end_date = listvo.getEnddate();
				Time start_time = listvo.getStarttime();
				Time end_time = listvo.getEndtime();
				String caregiver = listvo.getCaregiver();
				String res_code = listvo.getRes_code();
				String caretaker_code = listvo.getCaretaker_code();
				String location = listvo.getLocation();
				String addr = listvo.getAddr();
				String detail_addr = listvo.getDetail_addr();

				SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
				String fStartTime = timeFormat.format(start_time);
				String fEndTime = timeFormat.format(end_time);
				
	           
				String workTimes = fStartTime + "~" + fEndTime;
			%>

			<tr>
				<td><%=res_code%></td> <td><%=t_name%></td> 
				<td><button onclick="openPopup('<%=res_code %>')">더보기</button></td>
				
				<td><% if(location==null) { %>
				<a href="../reservation/rescareloc.jsp?res_code=<%=res_code%>">작성하기</a> <%}	
				else if(location!=null){if(location.equals("home")) {%>자택<%} 
				else { %><%=location%><%}} %></td>
				
				<td><% if(addr==null) { %>
				<a href="../reservation/rescareloc.jsp?res_code=<%=res_code%>">작성하기</a> <%}	
				else if(addr!=null){%><%=addr%> 
				<%if(detail_addr!=null) {%><br><%=detail_addr%><%}} %></td> 
				
				<td><% if(start_date==null ) { %>
				<a href="../reservation/res_date.jsp?res_code=<%=res_code%>&caretaker_code=<%=caretaker_code%>">작성하기</a> <%}	
				else if(start_date!=null){%>일시 : <%=start_date%> ~ <br> <%=end_date %><br>시간 : <%=workTimes%><%} %></td>
				
				<td><%
				List<TpreferenceVO> preList = dao2.listtpre(res_code);
				for(TpreferenceVO prevo : preList) {
					String pre_age_1 = prevo.getPre_age_1();
					
					if(pre_age_1 == null) { %>
					<a href="../reservation/matchService.jsp?res_code=<%=res_code%>">작성하기</a> <%}	
					else if(pre_age_1!=null){%><button onclick="openmatPopup('<%=res_code %>')">더보기</button>
					<%}} %></td>
					
				<td>
					<a href="../book/tapplyList.jsp?res_code=<%=res_code%>">매칭신청<br>리스트확인</a>
				</td>
				
				<td><a href="../reservation/resdelete.jsp?res_code=<%=res_code%>&caretaker_code=<%=caretaker_code%>"
					onclick="return delok();">취소</a></td>
			</tr>

			<%
			}
			%>
		</table>
	</form>
</div>