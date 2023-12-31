package patient;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Date;
import java.util.List;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import reservation.CaretakerinfoVO;

public class PatientresDAO {
	private PreparedStatement pstmt;
	private PreparedStatement stmnt;
	private ResultSet rs = null;
	private Connection conn;

	public void connect() throws Exception {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");

			DataSource dataFactory = (DataSource) envContext.lookup("jdbc/mysqlpool");
			// dataFactory = (DataSource) envContext.lookup("jdbc/oracle");

			conn = dataFactory.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<PatientresVO> listres(String m_id, int start) {
		List<PatientresVO> list = new ArrayList<PatientresVO>();

		try {
			connect();

			String sql = "SELECT * FROM reservation as res, reservation_info as resinfo, caretaker as c "
					+ "WHERE res.m_id = ? and res.caretaker_code = c.t_code "
					+ "and res.res_code=resinfo.res_code and caregiver_id is null "
					+ "and res.location is not null and res.addr is not null "
					+ "and resinfo.start_date is not null and resinfo.end_date is not null "
					+ "and resinfo.start_time is not null and resinfo.end_time is not null "
					+ "LIMIT " + start + ", 5";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);

			rs = pstmt.executeQuery();
			//System.out.println("rslist는 : " + rs);
			while (rs.next()) {
				String caretaker = rs.getString("t_name");
				Date start_date = rs.getDate("start_date");
				Date end_date = rs.getDate("end_date");
				Time start_time = rs.getTime("start_time");
				Time end_time = rs.getTime("end_time");
				String res_code = rs.getString("res_code");
				String location = rs.getString("location");
				String addr = rs.getString("addr");
				String detail_addr = rs.getString("detail_addr");
				String caregiver = rs.getString("caregiver_id");
				String t_code = rs.getString("caretaker_code");
				

					PatientresVO vo = new PatientresVO();
					vo.setCaretaker(caretaker);
					vo.setStartdate(start_date);
					vo.setEnddate(end_date);
					vo.setStarttime(start_time);
					vo.setEndtime(end_time);
					vo.setLocation(location);
					vo.setAddr(addr);
					vo.setDetail_addr(detail_addr);
					vo.setRes_code(res_code);
					vo.setCaretaker_code(t_code);
					
					if (caregiver != null) {
					String cgsql = "SELECT * FROM caregiver where g_id = ?";
					stmnt = conn.prepareStatement(cgsql);
					stmnt.setString(1, caregiver);
						
					ResultSet rs2 = stmnt.executeQuery();
					
					if(rs2.next()) {
					String gname = rs2.getString("g_name");
					String g_id = rs2.getString("g_id");

					vo.setCaregiver(g_id);
					vo.setG_name(gname);
					
					} } else {
					vo.setCaregiver(caregiver); 
					}
					list.add(vo);
				}


			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int listresCnt(String m_id) {
		int cnt=0;
		try {
			connect();
			
			String sql = "SELECT count(*) as cnt FROM reservation as res, reservation_info as resinfo, caretaker as c "
					+ "WHERE res.m_id = ? and res.caretaker_code = c.t_code "
					+ "and res.res_code=resinfo.res_code and caregiver_id is null "
					+ "and res.location is not null and res.addr is not null "
					+ "and resinfo.start_date is not null and resinfo.end_date is not null "
					+ "and resinfo.start_time is not null and resinfo.end_time is not null ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public List<PatientresVO> listnull(String m_id, int start) {
		List<PatientresVO> list = new ArrayList<PatientresVO>();

		try {
			connect();

			String sql = "SELECT DISTINCT res.res_code, c.t_name, resinfo.start_date, resinfo.end_date, resinfo.start_time, resinfo.end_time, res.location, res.addr, res.detail_addr, res.caretaker_code " +
		            "FROM reservation AS res " +
		            "JOIN reservation_info AS resinfo ON res.res_code = resinfo.res_code " +
		            "JOIN caretaker AS c ON res.caretaker_code = c.t_code " +
		            "WHERE res.m_id = ? AND (res.location IS NULL OR res.addr IS NULL OR resinfo.start_date IS NULL)"
		            + " LIMIT " + start + ", 5";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			System.out.println("rs는 : " + rs);
			while (rs.next()) {
				String caretaker = rs.getString("t_name");
				Date start_date = rs.getDate("start_date");
				Date end_date = rs.getDate("end_date");
				Time start_time = rs.getTime("start_time");
				Time end_time = rs.getTime("end_time");
				String res_code = rs.getString("res_code");
				String location = rs.getString("location");
				String addr = rs.getString("addr");
				String detail_addr = rs.getString("detail_addr");
				String t_code = rs.getString("caretaker_code");

					PatientresVO vo = new PatientresVO();
					vo.setCaretaker(caretaker);
					vo.setStartdate(start_date);
					vo.setEnddate(end_date);
					vo.setStarttime(start_time);
					vo.setEndtime(end_time);
					vo.setLocation(location);
					vo.setAddr(addr);
					vo.setDetail_addr(detail_addr);
					vo.setRes_code(res_code);
					vo.setCaretaker_code(t_code);
					
					list.add(vo);
				}


			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int listnullCnt(String m_id) {
		int cnt = 0;
		try {
			connect();
			
			String sql = "SELECT count(*) as cnt " +
					"FROM reservation AS res " +
					"JOIN reservation_info AS resinfo ON res.res_code = resinfo.res_code " +
					"JOIN caretaker AS c ON res.caretaker_code = c.t_code " +
					"WHERE res.m_id = ? AND (res.location IS NULL OR res.addr IS NULL OR resinfo.start_date IS NULL)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			System.out.println("rs는 : " + rs);
			while (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	

	public List<PatientresVO> comlistres(String m_id, int start) {
		List<PatientresVO> comlist = new ArrayList<PatientresVO>();

		try {
			connect();

			String sql = "SELECT * FROM reservation as res, reservation_info as resinfo, caretaker as c WHERE res.m_id = ? and res.caretaker_code = c.t_code and res.res_code=resinfo.res_code and caregiver_id is not null "
					+ "LIMIT " + start + ", 5";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				String caretaker = rs.getString("t_name");
				Date start_date = rs.getDate("start_date");
				Date end_date = rs.getDate("end_date");
				Time start_time = rs.getTime("start_time");
				Time end_time = rs.getTime("end_time");
				String res_code = rs.getString("res_code");
				String location = rs.getString("location");
				String addr = rs.getString("addr");
				String detail_addr = rs.getString("detail_addr");
				String caregiver = rs.getString("caregiver_id");
				String t_code = rs.getString("caretaker_code");

					PatientresVO vo = new PatientresVO();
					vo.setCaretaker(caretaker);
					vo.setStartdate(start_date);
					vo.setEnddate(end_date);
					vo.setStarttime(start_time);
					vo.setEndtime(end_time);
					vo.setCaregiver(caregiver);
					vo.setLocation(location);
					vo.setAddr(addr);
					vo.setDetail_addr(detail_addr);
					vo.setRes_code(res_code);
					vo.setCaretaker_code(t_code);
					
					if (caregiver != null) {
					String cgsql = "SELECT * FROM caregiver where g_id = ?";
					stmnt = conn.prepareStatement(cgsql);
					stmnt.setString(1, caregiver);
						
					ResultSet rs2 = stmnt.executeQuery();
					
					if(rs2.next()) {
					String gname = rs2.getString("g_name");
					String g_id = rs2.getString("g_id");

					vo.setCaregiver(g_id);
					vo.setG_name(gname);
					
					} } else {
					vo.setCaregiver(caregiver); 
					}
					comlist.add(vo);
				}


			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return comlist;
	}
	
	public int comlistresCnt(String m_id) {
		int cnt = 0;
		try {
			connect();
			
			String sql = "SELECT count(*) as cnt FROM reservation as res, reservation_info as resinfo, caretaker as c WHERE res.m_id = ? and res.caretaker_code = c.t_code and res.res_code=resinfo.res_code and caregiver_id is not null";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public List<PatientresVO> applylist(int start) {
		List<PatientresVO> list = new ArrayList<PatientresVO>();
		String caregiver = null;

		try {
			connect();

			String sql = "SELECT * FROM reservation as res, reservation_info as resinfo, caretaker as c"
					+ " WHERE res.caretaker_code = c.t_code and res.res_code=resinfo.res_code AND res.caregiver_id is null AND location is not null AND addr is not null AND start_date is not null AND start_date > now()";
			sql += " ORDER BY start_date LIMIT " + start + ", 5";
			pstmt = conn.prepareStatement(sql);
			System.out.println(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String caretaker = rs.getString("t_name");
				String t_gender = rs.getString("t_gender");
				String t_age = rs.getString("t_age");
				Date start_date = rs.getDate("start_date");
				Date end_date = rs.getDate("end_date");
				Time start_time = rs.getTime("start_time");
				Time end_time = rs.getTime("end_time");
				String res_code = rs.getString("res_code");
				caregiver = rs.getString("caregiver_id");
				String t_code = rs.getString("caretaker_code");
				String location = rs.getString("location");
				String addr = rs.getString("addr");
				String detail_addr = rs.getString("detail_addr");

				PatientresVO vo = new PatientresVO();
				vo.setCaretaker(caretaker);
				vo.setT_gender(t_gender);
				vo.setT_age(t_age);
				vo.setCaretaker(caretaker);
				vo.setStartdate(start_date);
				vo.setEnddate(end_date);
				vo.setStarttime(start_time);
				vo.setEndtime(end_time);
				vo.setCaregiver(caregiver);
				vo.setRes_code(res_code);
				vo.setCaretaker_code(t_code);
				vo.setLocation(location);
				vo.setAddr(addr);
				vo.setDetail_addr(detail_addr);

				list.add(vo);
			}

			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int applyCount() {
		int cnt = 0;
		try {
			connect();
			
			String sql = "SELECT count(*) as cnt FROM reservation as res, reservation_info as resinfo, caretaker as c"
					+ " WHERE res.caretaker_code = c.t_code and res.res_code=resinfo.res_code AND res.caregiver_id is null AND location is not null AND addr is not null AND start_date is not null AND start_date > now()";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				cnt = rs.getInt("cnt");
			}

			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public List<PatientresVO> resInfo(String res_code, String caretaker_code) {
		List<PatientresVO> list = new ArrayList<PatientresVO>();
		try {
			connect();

			String sql = "SELECT * FROM reservation as res, reservation_info as resinfo, caretaker as c WHERE res.caretaker_code = c.t_code and res.res_code=resinfo.res_code and res.res_code = ? and res.caretaker_code =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, res_code);
			pstmt.setString(2, caretaker_code);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				String caretaker = rs.getString("t_name");
				String t_gender = rs.getString("t_gender");
				String t_age = rs.getString("t_age");
				Date start_date = rs.getDate("start_date");
				Date end_date = rs.getDate("end_date");
				Time start_time = rs.getTime("start_time");
				Time end_time = rs.getTime("end_time");
				String location = rs.getString("location");
				String addr = rs.getString("addr");
				String detail_addr = rs.getString("detail_addr");
				String t_height = rs.getString("t_height");
				String t_weight = rs.getString("t_weight");
				String diagnosis = rs.getString("diagnosis");
				String consciousness = rs.getString("consciousness");
				String care_meal_yn = rs.getString("care_meal_yn");
				String care_toilet=rs.getString("care_toilet");
				String state_paralysis=rs.getString("state_paralysis");
				String state_mobility=rs.getString("state_mobility");
				String bedsore_yn=rs.getString("bedsore_yn");
				String suction_yn=rs.getString("suction_yn");
				String outpatient_yn=rs.getString("outpatient_yn");
				String care_night_yn=rs.getString("care_night_yn");
				String notice=rs.getString("notice");

				
					PatientresVO vo = new PatientresVO();
					vo.setCaretaker(caretaker);
					vo.setT_gender(t_gender);
					vo.setT_age(t_age);
					vo.setCaretaker(caretaker);
					vo.setStartdate(start_date);
					vo.setEnddate(end_date);
					vo.setStarttime(start_time);
					vo.setEndtime(end_time);
					vo.setRes_code(res_code);
					vo.setLocation(location);
					vo.setAddr(addr);
					vo.setDetail_addr(detail_addr);
					vo.setT_height(t_height);
					vo.setT_weight(t_weight);
					vo.setDiagnosis(diagnosis);
					vo.setConsciousness(consciousness);
					vo.setCare_meal_yn(care_meal_yn);
					vo.setCare_toilet(care_toilet);
					vo.setState_paralysis(state_paralysis);
					vo.setState_mobility(state_mobility);
					vo.setBedsore_yn(bedsore_yn);
					vo.setSuction_yn(suction_yn);
					vo.setOutpatient_yn(outpatient_yn);
					vo.setCare_night_yn(care_night_yn);
					vo.setNotice(notice);
					
					list.add(vo);

			}

			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	
	
	public List<PatientresInfoVO> listresinfo(String res_code) {
		List<PatientresInfoVO> list = new ArrayList<PatientresInfoVO>();

		try {
			connect();

			String sql = "SELECT * FROM reservation WHERE res_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, res_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String consciousness = rs.getString("consciousness");
				String care_meal_yn = rs.getString("care_meal_yn");
				String care_toilet = rs.getString("care_toilet");
				String state_paralysis = rs.getString("state_paralysis");
				String state_mobility = rs.getString("state_mobility");
				String bedsore_yn = rs.getString("bedsore_yn");
				String suction_yn = rs.getString("suction_yn");
				String outpatient_yn = rs.getString("outpatient_yn");
				String care_night_yn = rs.getString("care_night_yn");
				String notice = rs.getString("notice");

				PatientresInfoVO vo = new PatientresInfoVO();

				vo.setConsciousness(consciousness);
				vo.setCare_meal_yn(care_meal_yn);
				vo.setCare_toilet(care_toilet);
				vo.setState_paralysis(state_paralysis);
				vo.setState_mobility(state_mobility);
				vo.setBedsore_yn(bedsore_yn);
				vo.setSuction_yn(suction_yn);
				vo.setOutpatient_yn(outpatient_yn);
				vo.setCare_night_yn(care_night_yn);
				vo.setNotice(notice);

				list.add(vo);
			}

			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<TpreferenceVO> listtpre(String res_code) {
		List<TpreferenceVO> list = new ArrayList<TpreferenceVO>();

		try {
			connect();

			String sql = "SELECT * FROM reservation_info WHERE res_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, res_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				String pre_location_1 = rs.getString("pre_location_1");
				String pre_location_2 = rs.getString("pre_location_2");
				String pre_location_3 = rs.getString("pre_location_3");
				String pre_age_1 = rs.getString("pre_age_1");
				String pre_age_2 = rs.getString("pre_age_2");
				String pre_age_3 = rs.getString("pre_age_3");
				String pre_gender = rs.getString("pre_gender");
				String pre_qual = rs.getString("pre_qual");
				String pre_repre_1 = rs.getString("pre_repre_1");
				String pre_repre_2 = rs.getString("pre_repre_2");
				String pre_repre_3 = rs.getString("pre_repre_3");
				String pre_hourwage_1 = rs.getString("pre_hourwage_1");
				String pre_hourwage_2 = rs.getString("pre_hourwage_2");
				String pre_hourwage_3 = rs.getString("pre_hourwage_3");
				

				TpreferenceVO vo = new TpreferenceVO();
				
				vo.setPre_location_1(pre_location_1);
				vo.setPre_location_2(pre_location_2);
				vo.setPre_location_3(pre_location_3);
				vo.setPre_age_1(pre_age_1);
				vo.setPre_age_2(pre_age_2);
				vo.setPre_age_3(pre_age_3);
				vo.setPre_gender(pre_gender);
				vo.setPre_qual(pre_qual);
				vo.setPre_repre_1(pre_repre_1);
				vo.setPre_repre_2(pre_repre_2);
				vo.setPre_repre_3(pre_repre_3);
				vo.setPre_hourwage_1(pre_hourwage_1);
				vo.setPre_hourwage_2(pre_hourwage_2);
				vo.setPre_hourwage_3(pre_hourwage_3);
				

				list.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<TpreferenceVO> ranklist(String res_code) {
		List<TpreferenceVO> rlist = new ArrayList<TpreferenceVO>();

		try {
			connect();

			String sql = "SELECT * FROM reservation_info WHERE res_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, res_code);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				
				String rank1 = rs.getString("rank1");
				String rank2 = rs.getString("rank2");
				String rank3 = rs.getString("rank3");
				String rank4 = rs.getString("rank4");
				String rank5 = rs.getString("rank5");

				TpreferenceVO vo = new TpreferenceVO();
				
				
				vo.setRank1(rank1);
				vo.setRank2(rank2);
				vo.setRank3(rank3);
				vo.setRank4(rank4);
				vo.setRank5(rank5);

				rlist.add(vo);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rlist;
	}
	
	
	

	
}
