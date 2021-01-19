package test.servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import test.file.dao.FileDao;
import test.file.dto.FileDto;

@WebServlet("/file/list2")
public class FileListServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		final int PAGE_ROW_COUNT=5;
		final int PAGE_DISPLAY_COUNT=5;
		
		int pageNum=1;
		String strPageNum=request.getParameter("pageNum");
		if(strPageNum != null){
			pageNum=Integer.parseInt(strPageNum);
		}
		
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		/*
			[검색 키워드에 관한 처리]
			- 검색 키워드가 파라미터로 넘어 올 수도 있고 안 넘어 올 수도 있다
		*/
		String keyword=request.getParameter("keyword");
		String condition=request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면
		if(keyword==null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다
			//클라이언트 웹브라우저에 출력할때 "null"을 출력되지 않게 하기 위해서
			keyword="";
			condition="";
		}
		
		//특수기호를 인코딩한 키워드를 미리 준비한다 
		String encodedK=URLEncoder.encode(keyword);
		
		FileDto dto=new FileDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//ArrayList 객체의 참조값을 담을 지역변수를 미리 만든다
		List<FileDto> list=null;
		//전체 row의 갯수를 담을 지역변수를 미리 만든다
		int totalRow=0;
		//만일 검색 키워드가 넘어온다면
		if(!keyword.equals("")){
			//검색 조건이 무엇이냐에 따라 분기하기
			if(condition.equals("title_filename")){//제목+파일명 검색인 경우
				//검색 키워드를 FileDto에 담아서 전달한다
				dto.setTitle(keyword);
				dto.setOrgFileName(keyword);
				//제목+파일명 검색일때 호출하는 메소드를 이용해서 목록 얻어오기
				list=FileDao.getInstance().getListTF(dto);
				//제목+파일명 검색일때 호출하는 메소드를 이용해서 row의 갯수 얻어오기
				totalRow=FileDao.getInstance().getCountTF(dto);
			}else if(condition.equals("title")){//제목 검색인 경우
				dto.setTitle(keyword);
				list=FileDao.getInstance().getListT(dto);
				totalRow=FileDao.getInstance().getCountT(dto);
			}else if(condition.equals("writer")){//작성자 검색인 경우
				dto.setWriter(keyword);
				list=FileDao.getInstance().getListW(dto);
				totalRow=FileDao.getInstance().getCountW(dto);
			}//다른 검색 조건을 추가하고 싶다면 아래에 else if()를 계속 추가하면 된다
		}else{//검색 키워드가 넘어오지 않는다면
			//키워드가 없을 때 호출하는 메소드를 이용해서 파일 목록을 얻어온다
			list=FileDao.getInstance().getList(dto);
			//키워드가 없을 때 호출하는 메소드를 이용해서 전체 row의 갯수를 얻어온다
			totalRow=FileDao.getInstance().getCount();
		}
		
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
			
		int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		if(endPageNum > totalPageCount){
			endPageNum=totalPageCount;
		}
		
		//jsp 페이지에서 필요한 데이터를 request 영역에 담고
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("totalRow", totalRow);
		//jsp 페이지로 forward 이동해서 응답한다
		RequestDispatcher rd=request.getRequestDispatcher("/file/list2.jsp");
		rd.forward(request, response);
	}
}
