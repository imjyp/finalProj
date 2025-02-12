package kr.or.ddit.fullcalendarStore.jm.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.fullcalendarStore.jm.service.CalendarStoreService;
import kr.or.ddit.vo.CalendarVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/calendarStore")
public class CalendarStoreController {

	@Autowired
	CalendarStoreService calendarStoreService;
	
	//테스트
	@GetMapping("/test")
	public String calendarStoreTest(Model model) {
		// 일정 리스트를 서비스에서 가져와서 모델에 추가
		List<CalendarVO> getAllStore = this.calendarStoreService.getAllStore();
		model.addAttribute("getAllStore",getAllStore);
		// calList의 각 항목을 로그로 출력
        for (CalendarVO i : getAllStore) {
            log.info("calendarTest-> getAllStore: " + i.getCalNm());  // 예시로 이름만 출력
        }
        // fullcalendar/calendarTest.JSP로 리턴
		return "fullcalendarStore/calendarStoreTest";
	}
	
	// 메인페이지 이벤트 리스트 조회
	@GetMapping("/page")
	public String calendarStore(Model model) {
		// 일정 리스트를 서비스에서 가져와서 모델에 추가
		List<CalendarVO> getAllStore = this.calendarStoreService.getAllStore();
		model.addAttribute("getAllStore",getAllStore);
		// calList의 각 항목을 로그로 출력
        for (CalendarVO i : getAllStore) {
            log.info("getListCalendar-> getAllStore: " + i.getCalNm());  // 예시로 이름만 출력
        }
        // fullcalendar/calendarPage.JSP로 리턴
		return "fullcalendarStore/calendarStorePage";
	}
	
	
	//캘린더 데이터 events.jsp 전송
		@GetMapping("/events")
		@ResponseBody
	    public List<Map<String, Object>> getAllStore() {
	        // DB 데이터 가져오기
			List<CalendarVO> events = this.calendarStoreService.getAllStore();
			// 로그출력
			log.info("getAllStore-> events 출력:" + events);
	        // eventList는 반환할 이벤트 목록을 담기 위한 List<Map<String, Object>> 객체입니다.(각 이벤트를 Map객체 변환)
	        List<Map<String, Object>> eventList = new ArrayList<>();
	        
	        // events 목록에 있는 각 CalendarVO 객체를 순차적으로 처리합니다.
	        for (int i = 0; i < events.size(); i++) {
	            CalendarVO event = events.get(i);
	        	// eventData는 각 이벤트 정보를 저장하는 Map 객체입니다.(이벤트 정보를 Map 형태로 변환)
	            // Map에 저장되는 키(key)와 값(value)의 구조는 JSON 형식으로 변환됩니다.
	            Map<String, Object> eventData = new HashMap<>();
	            
	            //기본 필드 데이터(Non-standard Fields)
	            eventData.put("title", event.getCalTitle());	// 직원근무 제목
	            eventData.put("start", event.getCalStart());	// 직원근무 시작 시간
	            eventData.put("end", event.getCalEnd());		// 직원근무 종료 시간
	            eventData.put("backgroundColor", event.getBgColor());	// 직원근무 배경 색상
	            eventData.put("textColor", event.getTextColor());		// 직원근무 텍스트 색상
	            
	            //사용자 정의 필드 데이터(Non-standard Fields->extendedProps 객체)
	            eventData.put("userNo", event.getUserNo());			//작성자 번호
	            eventData.put("userNm", event.getUserNm());		// 작성자 이름
	            eventData.put("calendarTy", event.getCalendarTy());	//캘린더 타입
	            eventData.put("calNm", event.getCalNm());			//캘린더 번호
	            eventData.put("content", event.getCalContent());	//직원근무 내용
	            eventData.put("readerNo", event.getReaderNo());		//직원근무 대상자 아이디
	            eventData.put("readerNm", event.getReaderNm());		//직원근무 대상자 이름
	            
	            // eventData를 eventList에 추가합니다. (Map을 eventList에 추가)
	            eventList.add(eventData);
	            // 개별 이벤트 로그 출력
	            log.info("getAllStore-> eventData 출력: {} + {}", eventData.get("userNm"), eventData);
	        }
	        // @ResponseBody 어노테이션 덕분에 이 객체는 자동으로 JSON 형식으로 변환되어 클라이언트로 반환됩니다.
	        return eventList;  // JSON 형식으로 반환
	    }
		//--------------------------------------------------------------------------
	    // 캘린더 이벤트 저장
	    @PostMapping("/saveEvent")
	    @ResponseBody
		public Map<String, String> saveEvent(@RequestBody CalendarVO calendarVO) {
	        // 로그를 통해 받은 데이터 확인
	        log.info("saveEvent -> calendarVO: {}", calendarVO);

	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	   	 	String userNo = auth.getName();
	   	 	calendarVO.setUserNo(userNo);
	   	 	
	        // 캘린더 서비스로 이벤트 저장
	        this.calendarStoreService.saveEvent(calendarVO);
	        log.info("saveEvent -> successfully: {}+{}", calendarVO.getCalNm(),calendarVO.getCalTitle());
	        
	        // 성공적으로 저장되었음을 클라이언트에 응답
	        Map<String, String> response = new HashMap<>();
	        response.put("message", "Event saved successfully");
	        return response;
	    }

	    // 캘린더 이벤트 업데이트
	    @PutMapping("/updateEvent")
	    @ResponseBody
	    public int updateEvent(@RequestBody CalendarVO calendarVO) {
	        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        String userNo = auth.getName();
	        calendarVO.setUserNo(userNo);

	        // 로그를 통해 받은 데이터 확인
	        log.info("updateEvent -> calendarVO: {}", calendarVO);
	        
	        // 캘린더 서비스로 이벤트 업데이트
	        int result = this.calendarStoreService.updateEvent(calendarVO);
	        log.info("updateEvent -> successfully: {}+{}", calendarVO.getCalNm(), calendarVO.getCalTitle());
	        log.info("updateEvent -> result"+result);

	        // 성공적으로 저장되었음을 클라이언트에 응답
	        return result;
	    }

	    
	    // 캘린더 삭제 업데이트
	    @DeleteMapping("/deleteEvent")
	    @ResponseBody
	    public Map<String, String> deleteEvent(@RequestBody CalendarVO calendarVO) {
	   	 	
	    	// 로그를 통해 받은 데이터 확인
	        log.info("deleteEvent -> calendarVO: {}", calendarVO);

	        // 캘린더 서비스로 이벤트 삭제
	        this.calendarStoreService.deleteEvent(calendarVO);
	        log.info("deleteEvent -> successfully: {}+{}", calendarVO.getCalNm(),calendarVO.getCalTitle());
	        
	        // 성공적으로 저장되었음을 클라이언트에 응답
	        Map<String, String> response = new HashMap<>();
	        response.put("message", "Event saved successfully");
	        return response;
	    }



	    //merge로??
	    @ResponseBody
	    @PostMapping("/insertEvent")
	    public int insertEvent(@RequestBody Map<String, Object> map) {
	    	 Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		 	String userNo = auth.getName();
		 	map.put("userNo",userNo);
	    	log.info("인서트:"+map);
	    	
	    	int result = this.calendarStoreService.insertEvent(map);
	    	return result;
	    }
	    
	    @ResponseBody
	    @PostMapping("/updateContent")
	    public int updateContent(@RequestBody Map<String, Object> map) {
	    	log.info("업데이트:"+map);
	    	
	    	int result = this.calendarStoreService.updateContent(map);
	    	return result;
	    }
	    

	
}
