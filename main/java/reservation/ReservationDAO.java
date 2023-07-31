package reservation;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReservationDAO {
	private PreparedStatement pstmt;
	private PreparedStatement stmnt;
	private ResultSet rs = null;
	private Connection conn;
	

	public void connect() throws Exception {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			
			
			DataSource dataFactory = (DataSource) envContext.lookup("jdbc/mysqlpool");
		//	dataFactory = (DataSource) envContext.lookup("jdbc/oracle");
			
			conn=dataFactory.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int tinfocheck(String m_id) {
		System.out.println("피간병인 정보 확인");
		int ok = 0;
		try {
		connect();
		String sql = "SELECT count(*) FROM CARETAKER WHERE m_id = ?"; //피간병인 아이디에 등록된 피간병인 정보 갯수 확인
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, m_id);
		
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			ok = 1;
			System.out.println("피간병인 정보 o"); // 정보가 있는 경우, 해당 정보 출력
		} else {
			ok = 0;
			System.out.println("피간병인 정보 x, 등록필요"); // 정보가 없는 경우 등록필요
		}
		if (rs != null) { //rs 객체 종료
            try {
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (pstmt != null) { //pstmt 객체 종료
            try {
                pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (conn != null) { // conn 객체 종료
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ok;
	}
	
	public List<CaretakerinfoVO> listtname(String m_id) {
		List<CaretakerinfoVO> list= new ArrayList<CaretakerinfoVO>();
		
		try {
			connect();
				
			String sql = "SELECT t_name FROM CARETAKER WHERE m_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String t_name = rs.getString("t_name");
				
				CaretakerinfoVO vo = new CaretakerinfoVO(); 
				vo.setT_name(t_name);
				
				list.add(vo);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<CaretakerinfoVO> listtinfo(String m_id, String t_name) {
		List<CaretakerinfoVO> list= new ArrayList<CaretakerinfoVO>();
		try {
			connect();
				
			String sql = "SELECT * FROM CARETAKER WHERE m_id = ? and t_name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setString(2, t_name);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String tname = rs.getString("t_name");
				String t_code = rs.getString("t_code");
				int t_age = rs.getInt("t_age");
				int t_height = rs.getInt("t_height");
				int t_weight = rs.getInt("t_weight");
				String t_gender = rs.getString("t_gender");
				String diagnosis = rs.getString("diagnosis");
				
				
				CaretakerinfoVO vo = new CaretakerinfoVO();
				
				vo.setT_name(t_name);
				vo.setT_code(t_code);
				vo.setT_age(t_age);
				vo.setT_height(t_height);
				vo.setT_weight(t_weight);
				vo.setT_gender(t_gender);
				vo.setDiagnosis(diagnosis);
				
				list.add(vo);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String insert(ReservationVO vo) {
		
		String rescode = null;
		try {
			connect();
			
			
			String sql = 
			"INSERT INTO RESERVATION(m_id, caretaker_code, consciousness, care_meal_yn, care_toilet, state_paralysis, state_mobility, bedsore_yn, suction_yn, outpatient_yn, care_night_yn, notice)"
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getM_id());
			pstmt.setString(2, vo.getCaretaker_code());
			pstmt.setString(3, vo.getConsciousness());
			pstmt.setString(4, vo.getCare_meal_yn());
			pstmt.setString(5, vo.getCare_toilet());
			pstmt.setString(6, vo.getState_paralysis());
			pstmt.setString(7, vo.getState_mobility());
			pstmt.setString(8, vo.getBedsore_yn());
			pstmt.setString(9, vo.getSuction_yn());
			pstmt.setString(10, vo.getOutpatient_yn());
			pstmt.setString(11, vo.getCare_night_yn());
			pstmt.setString(12, vo.getNotice());
			
			pstmt.executeUpdate();
			
			String selectSql = "SELECT res_code FROM RESERVATION WHERE caretaker_code=? ORDER BY res_code DESC LIMIT 1";
			//피간병인 코드별 예약번호를 내림차순으로 정렬하여 가장 최근에 만들어진 예약코드 select
			
			stmnt = conn.prepareStatement(selectSql);
			stmnt.setString(1, vo.getCaretaker_code());
			
			rs = stmnt.executeQuery();
			
			if(rs.next()) {
				rescode = rs.getString("res_code");
				System.out.println(rescode);
			}
			rs.close();
			stmnt.close();
			pstmt.close();}
		 catch(Exception e) {
			e.printStackTrace();
			}

		return rescode;
	}
	
	public ReservationVO getLatestReservation(String m_id, String t_code) {
	    ReservationVO reservation = null;
	    try {
	        connect();

	        String sql = "SELECT * FROM reservation WHERE m_id = ? AND caretaker_code = ? ORDER BY res_code DESC LIMIT 1";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, m_id);
	        pstmt.setString(2, t_code);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            ReservationVO vo = new ReservationVO();
	            vo.setConsciousness(rs.getString("consciousness"));
	            vo.setCare_meal_yn(rs.getString("care_meal_yn"));
	            vo.setCare_toilet(rs.getString("care_toilet"));
	            vo.setState_paralysis(rs.getString("state_paralysis"));
	            vo.setState_mobility(rs.getString("state_mobility"));
	            vo.setBedsore_yn(rs.getString("bedsore_yn"));
	            vo.setSuction_yn(rs.getString("suction_yn"));
	            vo.setOutpatient_yn(rs.getString("outpatient_yn"));
	            vo.setCare_night_yn(rs.getString("care_night_yn"));
	            vo.setNotice(rs.getString("notice"));

	            reservation = vo;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return reservation;
	}

	public int updatehome(String res_code) {
		int result = 0;
		try {
			connect();
			String sql = "UPDATE  `suitecare`.`reservation` SET location='home' where res_code=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, res_code);
			
			result=pstmt.executeUpdate();
			
			System.out.println(result);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(pstmt!=null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		} return result;
	}
	
	public int updateaddr(ReservationVO vo) {
		int result = 0;
		try {
			connect();
			String sql = "UPDATE RESERVATION SET addr=?, detail_addr=? where caretaker_code=? and res_code=?";

			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, vo.getAddr());
			pstmt.setString(2, vo.getDetail_addr());
			pstmt.setString(3, vo.getCaretaker_code());
			pstmt.setString(4, vo.getRes_code());
			
			result=pstmt.executeUpdate();
			
			System.out.println(result);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(pstmt!=null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		} return result;
	}
	
	public int checkres(ReservationInfoVO vo) {
		int check_ok = 0;
	
		try {
			connect();
			
			String sql = "select * from reservation_info where start_date <= ? AND end_date >= ? and start_time<? and end_time>? and caretaker_code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getEnd_date());
			pstmt.setString(2, vo.getStart_date());
			pstmt.setString(3, vo.getEnd_time());
			pstmt.setString(4, vo.getStart_time());
			pstmt.setString(5, vo.getCaretaker_code());
			
			ResultSet rs = pstmt.executeQuery();

			if(rs.next()){
				check_ok=0;
				System.out.println("시간중복" + check_ok);
			} else {
				check_ok=1;
				System.out.println("예약가능" + check_ok);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return check_ok;
	}

	public int insertresinfo(ReservationInfoVO vo) {
		
		int result = 0;
		try {
			connect();
			
			String sql = 
					"INSERT INTO reservation_info(res_code, start_date, end_date, start_time, end_time, caretaker_code)"
							+ "VALUES(?,?,?,?,?,?)";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, vo.getRes_code());
					pstmt.setString(2, vo.getStart_date());
					pstmt.setString(3, vo.getEnd_date());
					pstmt.setString(4, vo.getStart_time());
					pstmt.setString(5, vo.getEnd_time());
					pstmt.setString(6, vo.getCaretaker_code());
					
					result = pstmt.executeUpdate();
					
					System.out.println("예약완료" + result);
					
					
					pstmt.close();}
				 catch(Exception e) {
					e.printStackTrace();
					}
		return result;
			}
	
	
	public int updatehospaddr(ReservationVO vo) {
		int result = 0;
		try {
			connect();
			String sql = "UPDATE RESERVATION SET location=?, addr=?, detail_addr=? where caretaker_code=? and res_code=?";

			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vo.getLocation());
			pstmt.setString(2, vo.getAddr());
			pstmt.setString(3, vo.getDetail_addr());
			pstmt.setString(4, vo.getCaretaker_code());
			pstmt.setString(5, vo.getRes_code());

			result=pstmt.executeUpdate();
			
			System.out.println(result);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try { if(pstmt!=null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		} return result;
	}
	
}
