package test.gallery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.gallery.dto.GalleryDto;
import test.util.DbcpBean;

public class GalleryDao {
	private static GalleryDao dao;
	private GalleryDao() {
		
	}
	public static GalleryDao getInstance() {
		if(dao==null) {
			dao=new GalleryDao();
		}
		return dao;
	}
	
	//파일 하나의 정보를 리턴하는 메소드
	public GalleryDto getData(int num) {
		GalleryDto dto=null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT *" + 
					" FROM" + 
					" 	(SELECT num, writer, caption, imagePath, regdate," + 
					" 	LAG(num, 1, 0) OVER (ORDER BY num DESC) AS prevNum," + 
					" 	LEAD(num, 1, 0) OVER (ORDER BY num DESC) AS nextNum" + 
					" 	FROM board_gallery" + 
					" 	ORDER BY num DESC)" + 
					" WHERE num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto=new GalleryDto();
				dto.setNum(num);
				dto.setWriter(rs.getString("writer"));
				dto.setCaption(rs.getString("caption"));
				dto.setImagePath(rs.getString("imagePath"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPrevNum(rs.getInt("prevNum"));
				dto.setNextNum(rs.getInt("nextNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	//업로드 된 사진 하나의 정보를 저장하는 메소드
	public boolean insert(GalleryDto dto) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int flag=0;
		try {
			conn=new DbcpBean().getConn();
			String sql="INSERT INTO board_gallery"
					+ " (num, writer, caption, imagePath, regdate)"
					+ " VALUES(board_gallery_seq.NEXTVAL, ?, ?, ?, SYSDATE)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getCaption());
			pstmt.setString(3, dto.getImagePath());
			flag=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e) {
				
			}
		}
		if(flag>0) {
			return true;
		}else {
			return false;
		}
	}
	
	//파일 정보를 삭제하는 메소드
	public boolean delete(int num) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		int flag=0;
		try {
			conn=new DbcpBean().getConn();
			String sql="DELETE FROM board_gallery"
					+ " WHERE num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			flag=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(flag>0) {
			return true;
		}else {
			return false;
		}
	}
	
	//업로드 된 모든 사진의 정보를 리턴하는 메소드
	public List<GalleryDto> getList(GalleryDto dto){
		List<GalleryDto> list=new ArrayList<GalleryDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT *" + 
					"	 FROM" + 
					"		   (SELECT result1.*, ROWNUM AS rnum" + 
					"		   FROM" + 
					"		       (SELECT num, writer, caption, imagePath, regdate" + 
					"		       FROM board_gallery" + 
					"		       ORDER BY num DESC) result1)" + 
					"	WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getStartRowNum());
			pstmt.setInt(2, dto.getEndRowNum());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GalleryDto dto2=new GalleryDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setCaption(rs.getString("caption"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setRegdate(rs.getString("regdate"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	//설명 검색인 경우에 파일 목록 리턴
	public List<GalleryDto> getListC(GalleryDto dto){
		List<GalleryDto> list=new ArrayList<GalleryDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT *" + 
				"	 FROM" + 
				"		   (SELECT result1.*, ROWNUM AS rnum" + 
				"		   FROM" + 
				"		       (SELECT num, writer, caption, imagePath, regdate" + 
				"		       FROM board_gallery" +
				"              WHERE caption LIKE '%'||?||'%'" +
				"		       ORDER BY num DESC) result1)" + 
				"	WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCaption());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GalleryDto dto2=new GalleryDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setCaption(rs.getString("caption"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setRegdate(rs.getString("regdate"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	//작성자 검색인 경우에 파일 목록 리턴
	public List<GalleryDto> getListW(GalleryDto dto){
		List<GalleryDto> list=new ArrayList<GalleryDto>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT *" + 
				"	 FROM" + 
				"		   (SELECT result1.*, ROWNUM AS rnum" + 
				"		   FROM" + 
				"		       (SELECT num, writer, caption, imagePath, regdate" + 
				"		       FROM board_gallery" +
				"              WHERE writer LIKE '%'||?||'%'" +
				"		       ORDER BY num DESC) result1)" + 
				"	WHERE rnum BETWEEN ? AND ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setInt(2, dto.getStartRowNum());
			pstmt.setInt(3, dto.getEndRowNum());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GalleryDto dto2=new GalleryDto();
				dto2.setNum(rs.getInt("num"));
				dto2.setWriter(rs.getString("writer"));
				dto2.setCaption(rs.getString("caption"));
				dto2.setImagePath(rs.getString("imagePath"));
				dto2.setRegdate(rs.getString("regdate"));
				list.add(dto2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	//전체 row의 갯수를 리턴하는 메소드
	public int getCount() {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num"
					+ " FROM board_gallery";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	//설명 검색인 경우 row의 갯수
	public int getCountC(GalleryDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num"
					+ " FROM board_gallery"
					+ " WHERE caption LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCaption());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
	
	//작성자 검색인 경우 row의 갯수
	public int getCountW(GalleryDto dto) {
		int count=0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT NVL(MAX(ROWNUM), 0) AS num"
					+ " FROM board_gallery"
					+ " WHERE writer LIKE '%'||?||'%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count=rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}
}
